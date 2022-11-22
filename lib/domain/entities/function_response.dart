import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FunctionResponse extends Equatable {
  bool error;
  String errorMessage = "";
  bool status;
  FunctionResponse(
      {required this.error, required this.errorMessage, required this.status});
  @override
  List<Object?> get props => [
        error,
        errorMessage,
        status,
      ];
}
