import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    AuthRepository _authRepository = new AuthRepository();
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
          if (_authModel.status == "true") {
            emit(AuthSuccess(_authModel));

            if (await setSharedPrefes(_authModel)) {
              //executing shared prefs and test input
              final SharedPreferences p = await _prefs;
            }
          } else {
            emit(AuthWrong());
          }
        } catch (e) {
          emit(AuthFailure());
        }
      } else if (event is SignUpEvent) {
        try {
          emit(AuthLoading());
          _authModel = await _authRepository.signUp(
              username: event.username, password: event.password);

          if (await setSharedPrefes(_authModel)) {
            //executing shared prefs and test input
            final SharedPreferences p = _prefs;
          }

          emit(AuthSuccess(_authModel));
        } catch (e) {
          emit(AuthFailure());
        }
      }
    });
  }
}
