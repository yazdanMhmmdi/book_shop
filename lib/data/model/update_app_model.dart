// ignore_for_file: must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/update_app.dart';

part 'update_app_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateAppModel extends UpdateApp {
  UpdateAppModel({
    String? id,
    String? version,
    String? creatorUserId,
    String? platform,
    String? apk,
    DateTime? pushDate,
  }) : super(
          creatorUserId: creatorUserId,
          id: id,
          platform: platform,
          pushDate: pushDate,
          version: version,
          apk: apk,
        );
  factory UpdateAppModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateAppModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAppModelToJson(this);
}
