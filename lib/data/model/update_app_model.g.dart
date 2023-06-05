// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAppModel _$UpdateAppModelFromJson(Map<String, dynamic> json) =>
    UpdateAppModel(
      id: json['id'] as String?,
      version: json['version'] as String?,
      creatorUserId: json['creator_user_id'] as String?,
      platform: json['platform'] as String?,
      apk: json['apk'] == null
          ? ''
          : UpdateApp.convertToURL(json['apk'] as String),
      pushDate: json['push_date'] == null
          ? null
          : DateTime.parse(json['push_date'] as String),
    );

Map<String, dynamic> _$UpdateAppModelToJson(UpdateAppModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'creator_user_id': instance.creatorUserId,
      'platform': instance.platform,
      'apk': instance.apk,
      'push_date': instance.pushDate?.toIso8601String(),
    };
