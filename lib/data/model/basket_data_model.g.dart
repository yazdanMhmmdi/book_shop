// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketDataModel _$BasketDataModelFromJson(Map<String, dynamic> json) =>
    BasketDataModel(
      totalPages: json['total_pages'] as int? ?? 0,
      currentPage: json['current_page'] as int? ?? 0,
      offsetPage: json['offset_page'] as int? ?? 0,
      taxPercent: json['tax_percent'] as int? ?? 0,
      tax: json['tax'] as int? ?? 0,
      deliveryCost: json['delivery_cost'] as int? ?? 0,
      fullCost: json['full_cost'] as int? ?? 0,
    );

Map<String, dynamic> _$BasketDataModelToJson(BasketDataModel instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'offset_page': instance.offsetPage,
      'tax_percent': instance.taxPercent,
      'tax': instance.tax,
      'delivery_cost': instance.deliveryCost,
      'full_cost': instance.fullCost,
    };
