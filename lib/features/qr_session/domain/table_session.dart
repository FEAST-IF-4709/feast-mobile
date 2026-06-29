// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'table_session.freezed.dart';
part 'table_session.g.dart';

/// Resolved outlet/table context from a scanned QR code.
///
/// Obtained via [QrSessionRepository.resolveToken] and persisted to
/// SharedPreferences across app restarts. All fields are sourced from the
/// backend resolve response except [resolvedAt], which is set client-side.
///
/// Actual API shape (POST /api/v1/public/tables/resolve/):
///   data.outlet = {id, name, brand_id, brand_name}
///   data.table  = {id, label}
///
/// Downstream features read this from [QrSessionNotifier] and pass
/// [outletId]/[brandId]/[tableId] **explicitly** as repository parameters
/// (never injected via interceptors — CLAUDE.md §3.3).
@freezed
class TableSession with _$TableSession {
  const factory TableSession({
    @JsonKey(name: 'outlet_id') required String outletId,
    @JsonKey(name: 'outlet_name') required String outletName,
    @JsonKey(name: 'brand_id') required String brandId,
    @JsonKey(name: 'brand_name') required String brandName,
    @JsonKey(name: 'table_id') required String tableId,
    @JsonKey(name: 'table_label') required String tableLabel,
    @JsonKey(name: 'resolved_at') required DateTime resolvedAt,
  }) = _TableSession;

  factory TableSession.fromJson(Map<String, dynamic> json) =>
      _$TableSessionFromJson(json);
}
