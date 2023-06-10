import 'package:json_annotation/json_annotation.dart';

import 'basket_data_model.dart';
import 'book_model.dart';

part 'basket_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BasketModel {
  BasketModel({
    required this.basket,
    required this.basketData,
  });
  late final List<BookModel> basket;
  late final BasketDataModel basketData;

  factory BasketModel.fromJson(Map<String, dynamic> json) =>
      _$BasketModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketModelToJson(this);
}
