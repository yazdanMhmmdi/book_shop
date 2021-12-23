import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/data/repository/auth_repository.dart';
import 'package:book_shop/presentation/widgets/global_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    AuthRepository _authRepository = AuthRepository();
    late SharedPreferences _prefs;

    Future<bool> setSharedPrefes(_model) async {
      return await _prefs.setString("id", _model.id.toString());
    }

    on<AuthEvent>((event, emit) async {
      AuthModel _authModel;

      _prefs = await SharedPreferences.getInstance();
      if (event is LoginEvent) {
        try {
          emit(AuthLoading());
          _authModel =
              await _authRepository.login(event.username, event.password);

          await delay(seconds: 2);
          if (_authModel.status == "true") {
            emit(AuthSuccess(_authModel));

            if (await setSharedPrefes(_authModel)) {
              GlobalWidget.userId = _authModel.id.toString();
            }
            await delay(seconds: 2);
            emit(AuthInitial());
          } else {
            emit(AuthWrong());
            await delay(seconds: 2);
            emit(AuthInitial());
          }
        } catch (e) {
          emit(AuthFailure());
          await delay(seconds: 2);
          emit(AuthInitial());
        }
      } else if (event is SignUpEvent) {
        try {
          emit(AuthLoading());
          _authModel = await _authRepository.signUp(
              username: event.username, password: event.password);
          if (_authModel.status == "true") {
            if (await setSharedPrefes(_authModel)) {
              GlobalWidget.userId = _authModel.id.toString();
            }
            await delay(seconds: 2);

            emit(AuthSuccess(_authModel));
            await delay(seconds: 2);
          } else {
            emit(AuthFailure());
            await delay(seconds: 2);
            emit(AuthInitial());
          }
        } catch (e) {
          emit(AuthFailure());
          await delay(seconds: 2);
          emit(AuthInitial());
          await delay(seconds: 2);
        }
      }
    });
  }

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }
}
