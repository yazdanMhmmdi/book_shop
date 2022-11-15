import 'package:book_shop/domain/entities/poster.dart';
import 'package:json_annotation/json_annotation.dart';
part 'poster_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PosterModel extends Poster {
  PosterModel({String? id, String? name, String? picture, String? posterText})
      : super(id: id, name: name, picture: picture, posterText: posterText);
  factory PosterModel.fromJson(Map<String, dynamic> json) =>
      _$PosterModelFromJson(json);

  Map<String, dynamic> toJson() => _$PosterModelToJson(this);
}
