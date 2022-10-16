import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/logic/cubit/cubit.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.formValidationCubit}) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
  }
  late FormValidationCubit formValidationCubit;
  late AuthModel _authModel;
  late SharedPreferences _prefs;
  final AuthRepository _authRepository = AuthRepository();
  late StreamSubscription streamSubscription;

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    _prefs = await SharedPreferences.getInstance();
    if (formValidationCubit.state.isPasswordValid &&
        formValidationCubit.state.isUsernameValid) {
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
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    _prefs = await SharedPreferences.getInstance();
    if (formValidationCubit.state.isUsernameValid &&
        formValidationCubit.state.isPasswordValid) {
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
  }

  Future<void> delay({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  Future<bool> setSharedPrefes(_model) async {
    return await _prefs.setString("id", _model.id.toString());
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}



/*

 else if (event is SignUpEvent) {


      */
