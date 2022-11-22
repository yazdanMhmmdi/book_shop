// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasketModel _$BasketModelFromJson(Map<String, dynamic> json) => BasketModel(
      basket: (json['basket'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      basketData:
          BasketDataModel.fromJson(json['basket_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BasketModelToJson(BasketModel instance) =>
    <String, dynamic>{
      'basket': instance.basket,
      'basket_data': instance.basketData,
    };
