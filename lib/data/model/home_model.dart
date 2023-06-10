import 'package:json_annotation/json_annotation.dart';

import 'book_model.dart';
import 'poster_model.dart';

part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel {
  List<BookModel>? mostSalesBooks;
  List<BookModel>? freshsBooks;
  List<PosterModel>? poster;
  HomeModel({this.freshsBooks, this.mostSalesBooks, this.poster});
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
