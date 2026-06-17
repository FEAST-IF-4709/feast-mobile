// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableSessionImpl _$$TableSessionImplFromJson(Map<String, dynamic> json) =>
    _$TableSessionImpl(
      outletId: json['outlet_id'] as String,
      outletName: json['outlet_name'] as String,
      brandId: json['brand_id'] as String,
      brandName: json['brand_name'] as String,
      tableId: json['table_id'] as String,
      tableLabel: json['table_label'] as String,
      resolvedAt: DateTime.parse(json['resolved_at'] as String),
    );

Map<String, dynamic> _$$TableSessionImplToJson(_$TableSessionImpl instance) =>
    <String, dynamic>{
      'outlet_id': instance.outletId,
      'outlet_name': instance.outletName,
      'brand_id': instance.brandId,
      'brand_name': instance.brandName,
      'table_id': instance.tableId,
      'table_label': instance.tableLabel,
      'resolved_at': instance.resolvedAt.toIso8601String(),
    };
