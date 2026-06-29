// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentCountdownHash() => r'71deddb5944ee101894c78593782c7e02f8e14b7';

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

/// Emits remaining time until [expiresAt], ticking every second.
///
/// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
///
/// Copied from [paymentCountdown].
@ProviderFor(paymentCountdown)
const paymentCountdownProvider = PaymentCountdownFamily();

/// Emits remaining time until [expiresAt], ticking every second.
///
/// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
///
/// Copied from [paymentCountdown].
class PaymentCountdownFamily extends Family<AsyncValue<Duration>> {
  /// Emits remaining time until [expiresAt], ticking every second.
  ///
  /// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
  ///
  /// Copied from [paymentCountdown].
  const PaymentCountdownFamily();

  /// Emits remaining time until [expiresAt], ticking every second.
  ///
  /// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
  ///
  /// Copied from [paymentCountdown].
  PaymentCountdownProvider call(DateTime expiresAt) {
    return PaymentCountdownProvider(expiresAt);
  }

  @override
  PaymentCountdownProvider getProviderOverride(
    covariant PaymentCountdownProvider provider,
  ) {
    return call(provider.expiresAt);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentCountdownProvider';
}

/// Emits remaining time until [expiresAt], ticking every second.
///
/// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
///
/// Copied from [paymentCountdown].
class PaymentCountdownProvider extends AutoDisposeStreamProvider<Duration> {
  /// Emits remaining time until [expiresAt], ticking every second.
  ///
  /// Yields [Duration.zero] when expired; [PaymentNotifier] schedules the refresh.
  ///
  /// Copied from [paymentCountdown].
  PaymentCountdownProvider(DateTime expiresAt)
    : this._internal(
        (ref) => paymentCountdown(ref as PaymentCountdownRef, expiresAt),
        from: paymentCountdownProvider,
        name: r'paymentCountdownProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$paymentCountdownHash,
        dependencies: PaymentCountdownFamily._dependencies,
        allTransitiveDependencies:
            PaymentCountdownFamily._allTransitiveDependencies,
        expiresAt: expiresAt,
      );

  PaymentCountdownProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expiresAt,
  }) : super.internal();

  final DateTime expiresAt;

  @override
  Override overrideWith(
    Stream<Duration> Function(PaymentCountdownRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaymentCountdownProvider._internal(
        (ref) => create(ref as PaymentCountdownRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        expiresAt: expiresAt,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Duration> createElement() {
    return _PaymentCountdownProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentCountdownProvider && other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, expiresAt.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PaymentCountdownRef on AutoDisposeStreamProviderRef<Duration> {
  /// The parameter `expiresAt` of this provider.
  DateTime get expiresAt;
}

class _PaymentCountdownProviderElement
    extends AutoDisposeStreamProviderElement<Duration>
    with PaymentCountdownRef {
  _PaymentCountdownProviderElement(super.provider);

  @override
  DateTime get expiresAt => (origin as PaymentCountdownProvider).expiresAt;
}

String _$paymentNotifierHash() => r'8f235401340efd7e79ead949f2163504a85076e4';

abstract class _$PaymentNotifier
    extends BuildlessAutoDisposeAsyncNotifier<QrisPayment> {
  late final String orderId;

  FutureOr<QrisPayment> build(String orderId);
}

/// Manages the QRIS payment lifecycle for [orderId].
///
/// Responsibilities:
/// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
/// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
///
/// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
/// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
///
/// Copied from [PaymentNotifier].
@ProviderFor(PaymentNotifier)
const paymentNotifierProvider = PaymentNotifierFamily();

/// Manages the QRIS payment lifecycle for [orderId].
///
/// Responsibilities:
/// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
/// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
///
/// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
/// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
///
/// Copied from [PaymentNotifier].
class PaymentNotifierFamily extends Family<AsyncValue<QrisPayment>> {
  /// Manages the QRIS payment lifecycle for [orderId].
  ///
  /// Responsibilities:
  /// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
  /// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
  ///
  /// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
  /// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
  ///
  /// Copied from [PaymentNotifier].
  const PaymentNotifierFamily();

  /// Manages the QRIS payment lifecycle for [orderId].
  ///
  /// Responsibilities:
  /// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
  /// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
  ///
  /// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
  /// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
  ///
  /// Copied from [PaymentNotifier].
  PaymentNotifierProvider call(String orderId) {
    return PaymentNotifierProvider(orderId);
  }

  @override
  PaymentNotifierProvider getProviderOverride(
    covariant PaymentNotifierProvider provider,
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
  String? get name => r'paymentNotifierProvider';
}

/// Manages the QRIS payment lifecycle for [orderId].
///
/// Responsibilities:
/// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
/// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
///
/// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
/// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
///
/// Copied from [PaymentNotifier].
class PaymentNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PaymentNotifier, QrisPayment> {
  /// Manages the QRIS payment lifecycle for [orderId].
  ///
  /// Responsibilities:
  /// - Calls `initiate-qris/` on first build and on expiry (idempotent, CLAUDE.md §8.3).
  /// - Schedules expiry timer; re-calls on expiry — no separate "regenerate" path.
  ///
  /// Payment settlement detection is handled exclusively by [OrderTrackingNotifier]
  /// via the shared `ws/order/{orderId}/` connection (CLAUDE.md §7.1).
  ///
  /// Copied from [PaymentNotifier].
  PaymentNotifierProvider(String orderId)
    : this._internal(
        () => PaymentNotifier()..orderId = orderId,
        from: paymentNotifierProvider,
        name: r'paymentNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$paymentNotifierHash,
        dependencies: PaymentNotifierFamily._dependencies,
        allTransitiveDependencies:
            PaymentNotifierFamily._allTransitiveDependencies,
        orderId: orderId,
      );

  PaymentNotifierProvider._internal(
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
  FutureOr<QrisPayment> runNotifierBuild(covariant PaymentNotifier notifier) {
    return notifier.build(orderId);
  }

  @override
  Override overrideWith(PaymentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PaymentNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PaymentNotifier, QrisPayment>
  createElement() {
    return _PaymentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentNotifierProvider && other.orderId == orderId;
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
mixin PaymentNotifierRef on AutoDisposeAsyncNotifierProviderRef<QrisPayment> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _PaymentNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<PaymentNotifier, QrisPayment>
    with PaymentNotifierRef {
  _PaymentNotifierProviderElement(super.provider);

  @override
  String get orderId => (origin as PaymentNotifierProvider).orderId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
