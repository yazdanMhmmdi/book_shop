import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class BasketData extends Equatable {
  @JsonKey(defaultValue: 0)
  int? totalPages;
  @JsonKey(defaultValue: 0)
  int? currentPage;
  @JsonKey(defaultValue: 0)
  int? offsetPage;
  @JsonKey(defaultValue: 0)
  int? taxPercent;
  @JsonKey(defaultValue: 0)
  int? tax;
  @JsonKey(defaultValue: 0)
  int? deliveryCost;
  @JsonKey(defaultValue: 0)
  int? fullCost;
  BasketData({
    this.totalPages,
    this.currentPage,
    this.deliveryCost,
    this.fullCost,
    this.offsetPage,
    this.tax,
    this.taxPercent,
  });

  @override
  List<Object?> get props => [
        totalPages,
        currentPage,
        deliveryCost,
        fullCost,
        offsetPage,
        tax,
        taxPercent,
      ];
}
