import 'package:json_annotation/json_annotation.dart';

import 'book_model.dart';
import 'response_data_model.dart';

part 'title_posts_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TitlePostsModel {
  late List<BookModel> books;
  late ResponseDataModel responseData;
  TitlePostsModel({required this.books, required this.responseData});
  factory TitlePostsModel.fromJson(Map<String, dynamic> json) =>
      _$TitlePostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TitlePostsModelToJson(this);
}
