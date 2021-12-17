part of 'form_validation_cubit.dart';

abstract class FormValidationState extends Equatable {
  const FormValidationState();

  @override
  List<Object> get props => [];
}

class FormValidationInitial extends FormValidationState {}

class FormValidationStatus extends FormValidationState {
  bool usernameStatus = false, passwordStatus = false;

  FormValidationStatus({required this.usernameStatus, required this.passwordStatus});

  @override
  List<Object> get props => [this.usernameStatus, this.passwordStatus];
}
