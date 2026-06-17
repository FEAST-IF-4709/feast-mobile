/// Backend fulfillment status values — used as source of truth in the
/// order tracking stepper. Display labels are mapped separately.
enum FulfillmentStatus {
  received('RECEIVED'),
  inProgress('IN_PROGRESS'),
  ready('READY'),
  served('SERVED'),
  completed('COMPLETED'),
  cancelled('CANCELLED');

  const FulfillmentStatus(this.value);
  final String value;

  static FulfillmentStatus? fromString(String? s) {
    if (s == null) return null;
    for (final e in values) {
      if (e.value == s) return e;
    }
    return null;
  }

  /// Display label per Mobile PRD §5.9 — never hardcoded as the enum name.
  String get displayLabel => switch (this) {
        FulfillmentStatus.received => 'Pesanan Diterima',
        FulfillmentStatus.inProgress => 'Sedang Dimasak',
        FulfillmentStatus.ready => 'Siap Disajikan',
        FulfillmentStatus.served => 'Sudah Disajikan',
        FulfillmentStatus.completed => 'Selesai',
        FulfillmentStatus.cancelled => 'Dibatalkan',
      };

  /// Short subtitle shown beneath each stepper step label.
  String get stepSubtitle => switch (this) {
        FulfillmentStatus.received => 'Restoran telah menerima pesananmu',
        FulfillmentStatus.inProgress => 'Chef sedang memasak pesananmu',
        FulfillmentStatus.ready => 'Pesananmu siap untuk disajikan',
        FulfillmentStatus.served => 'Pesananmu telah tersaji di mejamu',
        FulfillmentStatus.completed => 'Terima kasih, nikmati pesananmu!',
        FulfillmentStatus.cancelled => '',
      };

  /// Large heading shown at the top of the tracking screen.
  String get headerTitle => switch (this) {
        FulfillmentStatus.received => 'Pesanan Diterima!',
        FulfillmentStatus.inProgress => 'Sedang Mempersiapkan Pesananmu',
        FulfillmentStatus.ready => 'Pesananmu Siap!',
        FulfillmentStatus.served => 'Selamat Menikmati!',
        FulfillmentStatus.completed => 'Pesanan Selesai',
        FulfillmentStatus.cancelled => 'Pesanan Dibatalkan',
      };

  /// CANCELLED is never a stepper step (CLAUDE.md §7.6).
  static const stepperStatuses = [
    FulfillmentStatus.received,
    FulfillmentStatus.inProgress,
    FulfillmentStatus.ready,
    FulfillmentStatus.served,
    FulfillmentStatus.completed,
  ];

  /// 0-based index in the stepper (-1 if not a stepper status i.e. CANCELLED).
  int get stepIndex => stepperStatuses.indexOf(this);

  /// SERVED, COMPLETED, and CANCELLED are terminal — close WS and stop polling.
  ///
  /// SERVED is treated as customer-facing terminal: food is at the table,
  /// no further updates matter to the customer. COMPLETED is a staff-side
  /// closure that the customer doesn't need to wait for.
  bool get isTerminal =>
      this == FulfillmentStatus.served ||
      this == FulfillmentStatus.completed ||
      this == FulfillmentStatus.cancelled;
}
