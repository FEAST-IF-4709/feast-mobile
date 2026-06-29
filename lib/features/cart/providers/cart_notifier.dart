import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/cart_item.dart';

part 'cart_notifier.g.dart';

/// Active cart for the current QR table session.
///
/// Persists across navigation (keepAlive). Cleared explicitly via [clearCart]
/// on logout or when a new QR session is resolved.
///
/// Price arithmetic uses [double.parse] on the String decimal from the API
/// to avoid spreading raw strings into the UI.
@Riverpod(keepAlive: true)
class CartNotifier extends _$CartNotifier {
  @override
  List<CartItem> build() => [];

  /// Adds [item] to the cart, or increments quantity if already present.
  void addItem(CartItem item) {
    final existing = state.indexWhere(
      (e) => e.outletProductId == item.outletProductId,
    );
    if (existing == -1) {
      state = [...state, item];
    } else {
      state = [
        for (final e in state)
          if (e.outletProductId == item.outletProductId)
            e.copyWith(quantity: e.quantity + item.quantity)
          else
            e,
      ];
    }
  }

  /// Removes the line item with [outletProductId] from the cart.
  void removeItem(String outletProductId) {
    state = state
        .where((e) => e.outletProductId != outletProductId)
        .toList();
  }

  /// Sets the quantity for [outletProductId]. Removes the item if [quantity] ≤ 0.
  void updateQuantity(String outletProductId, int quantity) {
    if (quantity <= 0) {
      removeItem(outletProductId);
      return;
    }
    state = [
      for (final e in state)
        if (e.outletProductId == outletProductId)
          e.copyWith(quantity: quantity)
        else
          e,
    ];
  }

  /// Updates the per-item kitchen note for [outletProductId].
  void updateItemNotes(String outletProductId, String notes) {
    state = [
      for (final e in state)
        if (e.outletProductId == outletProductId)
          e.copyWith(itemNotes: notes.isEmpty ? null : notes)
        else
          e,
    ];
  }

  /// Removes all items from the cart.
  void clearCart() => state = [];

  /// Total price across all line items (sum of effectivePrice × quantity).
  double get totalAmount => state.fold(0.0, (sum, item) {
        return sum + double.parse(item.effectivePrice) * item.quantity;
      });

  /// Total number of individual units across all line items.
  int get totalItemCount =>
      state.fold(0, (sum, item) => sum + item.quantity);
}
