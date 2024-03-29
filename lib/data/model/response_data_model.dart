// ignore_for_file: must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/response_data.dart';

part 'response_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseDataModel extends ResponseData {
  ResponseDataModel({
    int? totalPages,
    int? currentPage,
    int? pageSize,
    int? offsetPage,
  }) : super(
          currentPage: currentPage,
          offsetPage: offsetPage,
          pageSize: pageSize,
          totalPages: totalPages,
        );

  factory ResponseDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataModelToJson(this);
}
