// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseData extends Equatable {
  int? totalPages;
  int? currentPage;
  int? pageSize;
  int? offsetPage;
  ResponseData({
    this.currentPage,
    this.offsetPage,
    this.pageSize,
    this.totalPages,
  });
  @override
  List<Object?> get props => [
        totalPages,
        currentPage,
        pageSize,
        offsetPage,
      ];
}
