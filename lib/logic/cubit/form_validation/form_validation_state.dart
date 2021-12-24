part of 'form_validation_cubit.dart';

class FormValidationState extends Equatable {
  bool isUsernameValid = false, isPasswordValid = false;
  FormValidationState(
      {required this.isUsernameValid, required this.isPasswordValid});
  @override
  List<Object> get props => [isUsernameValid, isPasswordValid];
}
