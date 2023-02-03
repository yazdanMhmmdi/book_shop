import 'package:book_shop/constants/constants.dart';
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
