// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Poster extends Equatable {
  String? id;
  @JsonKey(defaultValue: '')
  String? picture;
  @JsonKey(defaultValue: '')
  String? name;
  @JsonKey(defaultValue: '')
  String? posterText;
  Poster({
    this.id,
    this.name,
    this.picture,
    this.posterText,
  });

  @override
  List<Object?> get props => [name, id, picture, posterText];
}
