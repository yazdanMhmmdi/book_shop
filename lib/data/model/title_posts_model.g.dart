// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_posts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitlePostsModel _$TitlePostsModelFromJson(Map<String, dynamic> json) =>
    TitlePostsModel(
      books: (json['books'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      responseData: ResponseDataModel.fromJson(
          json['response_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TitlePostsModelToJson(TitlePostsModel instance) =>
    <String, dynamic>{
      'books': instance.books,
      'response_data': instance.responseData,
    };
