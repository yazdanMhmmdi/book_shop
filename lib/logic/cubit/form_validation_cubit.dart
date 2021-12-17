import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(FormValidationInitial());

  bool usernameStatus = false;
  bool passwordStatus = false;

  void authValidatiors(String username, password) {
    if (username.length < 17 && username.length >= 5) {
      usernameStatus = true;
    } else {
      usernameStatus = false;
    }

    if (password.length >= 8 && password.length < 17) {
      passwordStatus = true;
    } else {
      passwordStatus = false;
    }
    emit(FormValidationStatus(
        usernameStatus: usernameStatus, passwordStatus: passwordStatus));
  }
}
