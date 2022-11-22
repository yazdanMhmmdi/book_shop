// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionResponseModel _$FunctionResponseModelFromJson(
        Map<String, dynamic> json) =>
    FunctionResponseModel(
      error: json['error'] as bool,
      errorMessage: json['error_message'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$FunctionResponseModelToJson(
        FunctionResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_message': instance.errorMessage,
      'status': instance.status,
    };
