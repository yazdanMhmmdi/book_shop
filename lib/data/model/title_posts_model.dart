import 'book_model.dart';
import 'response_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/response_data.dart';
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
