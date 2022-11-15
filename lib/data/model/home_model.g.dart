// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      freshsBooks: (json['freshsBooks'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostSalesBooks: (json['mostSalesBooks'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      poster: (json['poster'] as List<dynamic>?)
          ?.map((e) => PosterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'mostSalesBooks':
          instance.mostSalesBooks?.map((e) => e.toJson()).toList(),
      'freshsBooks': instance.freshsBooks?.map((e) => e.toJson()).toList(),
      'poster': instance.poster?.map((e) => e.toJson()).toList(),
    };
