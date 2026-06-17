import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

/// A single line item in the customer's active cart.
///
/// [effectivePrice] mirrors the backend's decimal string (e.g. "8000.00")
/// so it can be sent back in the order payload without float precision issues.
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String outletProductId,
    required String name,
    required String effectivePrice,
    required int quantity,
    String? itemNotes,
    String? imageUrl,
  }) = _CartItem;
}
