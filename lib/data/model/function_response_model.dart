import '../../domain/entities/function_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'function_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FunctionResponseModel extends FunctionResponse {
  FunctionResponseModel(
      {required bool error, required String errorMessage, required bool status})
      : super(error: error, errorMessage: errorMessage, status: status);

  factory FunctionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FunctionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionResponseModelToJson(this);
}
