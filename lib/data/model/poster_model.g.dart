// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosterModel _$PosterModelFromJson(Map<String, dynamic> json) => PosterModel(
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      posterText: json['poster_text'] as String? ?? '',
    );

Map<String, dynamic> _$PosterModelToJson(PosterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picture': instance.picture,
      'name': instance.name,
      'poster_text': instance.posterText,
    };
