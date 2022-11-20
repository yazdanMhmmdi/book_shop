// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDataModel _$ResponseDataModelFromJson(Map<String, dynamic> json) =>
    ResponseDataModel(
      totalPages: json['total_pages'] as int?,
      currentPage: json['current_page'] as int?,
      pageSize: json['page_size'] as int?,
      offsetPage: json['offset_page'] as int?,
    );

Map<String, dynamic> _$ResponseDataModelToJson(ResponseDataModel instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'offset_page': instance.offsetPage,
    };
