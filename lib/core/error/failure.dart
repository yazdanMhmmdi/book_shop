// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../constants/constants.dart';

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
  SameUsernameFailure({this.message = Strings.thisUsernameAlreadyExists});
  @override
  List<Object?> get props => [this.message];
}

class DuplicatedBookFailure extends Failure {
  String? message;
  DuplicatedBookFailure({this.message = Strings.detailsAlreadyBookChoosed});
  @override
  List<Object?> get props => [this.message];
}

class WrongParametersFailure extends Failure {
  String? message;
  WrongParametersFailure({this.message = Strings.wrongParameters});
  @override
  List<Object?> get props => [this.message];
}

class GuestUserFailure extends Failure {
  String? message;
  GuestUserFailure({this.message = Strings.gustUserFailure});
  @override
  List<Object?> get props => [this.message];
}
