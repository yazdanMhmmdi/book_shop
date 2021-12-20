part of 'form_validation_cubit.dart';

abstract class FormValidationState extends Equatable {
  bool usernameStatus = false, passwordStatus = false;
  FormValidationState(this.usernameStatus, this.passwordStatus);
  @override
  List<Object> get props => [usernameStatus, passwordStatus];
}

class FormValidationInitial extends FormValidationState {
  FormValidationInitial(bool usernameStatus, bool passwordStatus)
      : super(usernameStatus, passwordStatus);
}

class FormValidationStatus extends FormValidationState {
  FormValidationStatus(bool usernameStatus, bool passwordStatus)
      : super(usernameStatus, passwordStatus);
}
