import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  AuthRepository _authRepository = new AuthRepository();
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // TODO: implement mapEventToState
    AuthModel _authModel;
    if (event is LoginEvent) {
      try {
        yield AuthLoading();
        print('AuthLoading');
        _authModel = await _authRepository.login();
        if (_authModel.status == "true") {
          yield AuthSuccess(_authModel);
          print('AuthSuccess');
        } else {
          yield AuthFailure();
          print('AuthFailure');
        }
      } catch (_) {
        yield AuthFailure();
        print('auth failure');
        throw Exception();
      }
    }
  }
}
