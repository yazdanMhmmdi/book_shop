// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/url_provider.dart';


class UpdateApp extends Equatable {
  String? id;
  String? version;
  String? creatorUserId;
  String? platform;
  @JsonKey(defaultValue: '', fromJson: convertToURL)
  String? apk;
  DateTime? pushDate;

  UpdateApp({
    required this.pushDate,
    required this.platform,
    required this.creatorUserId,
    required this.version,
    required this.id,
    required this.apk,
  });
  @override
  List<Object?> get props => [
        id,
        version,
        creatorUserId,
        platform,
        pushDate,
        apk,
      ];

  static String? convertToURL(String urlAddress) {
    return UrlProvider.getAddress(urlAddress);
  }
}
