import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}
//  Some General Failures

class ServerFailure extends Failure {
  String? message;
  ServerFailure({this.message = ""});
  @override
  List<Object?> get props => [this.message];
}

class SameUsernameFailure extends Failure {
  String? message;
  SameUsernameFailure({this.message = "این نام کاربری قبلا کرفته شده است"});
  @override
  List<Object?> get props => [this.message];
}
