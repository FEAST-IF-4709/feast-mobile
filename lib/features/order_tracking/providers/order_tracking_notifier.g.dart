// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_tracking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderTrackingNotifierHash() =>
    r'e4de62c062da6e027e567d9918072ff955f3f8ca';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$OrderTrackingNotifier
    extends BuildlessAutoDisposeAsyncNotifier<OrderTrackingState> {
  late final String orderId;

  FutureOr<OrderTrackingState> build(String orderId);
}

/// Single WebSocket + polling owner for a tracked order.
///
/// Handles both `fulfillment.status_changed` and `payment.status_changed`
/// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
/// ONE connection per order (CLAUDE.md §7.1).
///
/// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
/// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
///
/// Copied from [OrderTrackingNotifier].
@ProviderFor(OrderTrackingNotifier)
const orderTrackingNotifierProvider = OrderTrackingNotifierFamily();

/// Single WebSocket + polling owner for a tracked order.
///
/// Handles both `fulfillment.status_changed` and `payment.status_changed`
/// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
/// ONE connection per order (CLAUDE.md §7.1).
///
/// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
/// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
///
/// Copied from [OrderTrackingNotifier].
class OrderTrackingNotifierFamily
    extends Family<AsyncValue<OrderTrackingState>> {
  /// Single WebSocket + polling owner for a tracked order.
  ///
  /// Handles both `fulfillment.status_changed` and `payment.status_changed`
  /// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
  /// ONE connection per order (CLAUDE.md §7.1).
  ///
  /// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
  /// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
  ///
  /// Copied from [OrderTrackingNotifier].
  const OrderTrackingNotifierFamily();

  /// Single WebSocket + polling owner for a tracked order.
  ///
  /// Handles both `fulfillment.status_changed` and `payment.status_changed`
  /// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
  /// ONE connection per order (CLAUDE.md §7.1).
  ///
  /// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
  /// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
  ///
  /// Copied from [OrderTrackingNotifier].
  OrderTrackingNotifierProvider call(String orderId) {
    return OrderTrackingNotifierProvider(orderId);
  }

  @override
  OrderTrackingNotifierProvider getProviderOverride(
    covariant OrderTrackingNotifierProvider provider,
  ) {
    return call(provider.orderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderTrackingNotifierProvider';
}

/// Single WebSocket + polling owner for a tracked order.
///
/// Handles both `fulfillment.status_changed` and `payment.status_changed`
/// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
/// ONE connection per order (CLAUDE.md §7.1).
///
/// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
/// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
///
/// Copied from [OrderTrackingNotifier].
class OrderTrackingNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OrderTrackingNotifier,
          OrderTrackingState
        > {
  /// Single WebSocket + polling owner for a tracked order.
  ///
  /// Handles both `fulfillment.status_changed` and `payment.status_changed`
  /// on `ws/order/{orderId}/` so the Payment screen and Tracking screen share
  /// ONE connection per order (CLAUDE.md §7.1).
  ///
  /// Reconnection uses exponential backoff (1 s → 2 s → 4 s … capped at 30 s).
  /// [OrderTrackingState.isReconnecting] drives an amber UI banner (CLAUDE.md §7.2).
  ///
  /// Copied from [OrderTrackingNotifier].
  OrderTrackingNotifierProvider(String orderId)
    : this._internal(
        () => OrderTrackingNotifier()..orderId = orderId,
        from: orderTrackingNotifierProvider,
        name: r'orderTrackingNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$orderTrackingNotifierHash,
        dependencies: OrderTrackingNotifierFamily._dependencies,
        allTransitiveDependencies:
            OrderTrackingNotifierFamily._allTransitiveDependencies,
        orderId: orderId,
      );

  OrderTrackingNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  FutureOr<OrderTrackingState> runNotifierBuild(
    covariant OrderTrackingNotifier notifier,
  ) {
    return notifier.build(orderId);
  }

  @override
  Override overrideWith(OrderTrackingNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderTrackingNotifierProvider._internal(
        () => create()..orderId = orderId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    OrderTrackingNotifier,
    OrderTrackingState
  >
  createElement() {
    return _OrderTrackingNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderTrackingNotifierProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderTrackingNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<OrderTrackingState> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderTrackingNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OrderTrackingNotifier,
          OrderTrackingState
        >
    with OrderTrackingNotifierRef {
  _OrderTrackingNotifierProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderTrackingNotifierProvider).orderId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
