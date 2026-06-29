/// Voucher template (catalog item) returned by /api/v1/customers/voucher-catalog/.
///
/// Plain immutable class — no freezed / build_runner needed.
class VoucherTemplate {
  const VoucherTemplate({
    required this.id,
    required this.brandId,
    this.brandName,
    required this.title,
    this.description = '',
    this.imageUrl,
    required this.pointsCost,
    this.discountType,
    this.discountValue,
    this.applicableScope = 'ALL',
    this.isActive = true,
    this.validDays = 30,
  });

  final String id;
  final String brandId;
  final String? brandName;
  final String title;
  final String description;
  final String? imageUrl;
  final int pointsCost;
  final String? discountType;
  final String? discountValue;
  final String applicableScope;
  final bool isActive;
  final int validDays;

  factory VoucherTemplate.fromJson(Map<String, dynamic> json) {
    return VoucherTemplate(
      id: json['id'] as String,
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String?,
      title: json['title'] as String,
      description: (json['description'] as String?) ?? '',
      imageUrl: json['image_url'] as String?,
      pointsCost: (json['points_cost'] as num).toInt(),
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value']?.toString(),
      applicableScope: (json['applicable_scope'] as String?) ?? 'ALL',
      isActive: (json['is_active'] as bool?) ?? true,
      validDays: (json['valid_days'] as num?)?.toInt() ?? 30,
    );
  }
}
