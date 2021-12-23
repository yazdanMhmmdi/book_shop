import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  static bool usernameStatus = true;
  static bool passwordStatus = true;

  FormValidationCubit()
      : super(FormValidationInitial(usernameStatus, passwordStatus));

  void authValidatiors(String username, String password,
      {required Function doAfterValidation}) {
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
    if (passwordStatus && usernameStatus) doAfterValidation.call();
    emit(FormValidationStatus(usernameStatus, passwordStatus));
  }
}
