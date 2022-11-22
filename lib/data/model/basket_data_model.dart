import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/basket_data.dart';
part 'basket_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BasketDataModel extends BasketData {
  BasketDataModel({
    int? totalPages,
    int? currentPage,
    int? offsetPage,
    int? taxPercent,
    int? tax,
    int? deliveryCost,
    int? fullCost,
  }) : super(
          currentPage: currentPage,
          offsetPage: offsetPage,
          totalPages: totalPages,
          deliveryCost: deliveryCost,
          fullCost: fullCost,
          tax: tax,
          taxPercent: taxPercent,
        );

  factory BasketDataModel.fromJson(Map<String, dynamic> json) =>
      _$BasketDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketDataModelToJson(this);
}
