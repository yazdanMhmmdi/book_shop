import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class User extends Equatable {
  String id;
  String username;
  String password;
  String ruleType;
  String picture;
  String thumbPicture;
  @JsonKey(
      fromJson: createAt) // parse timestamp from server to DateTime in client
  DateTime createdAt;
  User({
    required this.id,
    required this.password,
    required this.username,
    required this.createdAt,
    required this.picture,
    required this.ruleType,
    required this.thumbPicture,
  });

  @override
  List<Object?> get props => [
        id,
        password,
        username,
        createdAt,
        picture,
        ruleType,
        thumbPicture,
      ];

  static DateTime createAt(data) {
    return DateTime.parse(data);
  }
}
