// ignore_for_file: must_be_immutable

import '../../domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends User {
  UserModel(
      {required String id,
      required String password,
      required String username,
      required DateTime createdAt,
      String picture = "",
      required String ruleType,
      String thumbPicture = ""})
      : super(
            id: id,
            password: password,
            username: username,
            createdAt: createdAt,
            picture: picture,
            ruleType: ruleType,
            thumbPicture: thumbPicture);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
