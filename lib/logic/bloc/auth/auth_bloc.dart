import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/core/error/failure.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/domain/usecases/login_usecase.dart';
import 'package:book_shop/domain/usecases/sign_up_usecase.dart';
import 'package:book_shop/logic/cubit/cubit.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/params/auth_params.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required this.formValidationCubit,
      required this.loginUsecase,
      required this.signUpUsecase})
      : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
  }
  late FormValidationCubit formValidationCubit;
  Either<Failure, AuthModel>? failureOrSuccess;
  late SharedPreferences _prefs;
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;

  late StreamSubscription streamSubscription;
  AuthRequestParams? params;

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    _prefs = await SharedPreferences.getInstance();
    if (formValidationCubit.state.isPasswordValid &&
        formValidationCubit.state.isUsernameValid) {
      try {
        emit(AuthLoading());
        params = AuthRequestParams(
            username: event.username, password: event.password);
        failureOrSuccess = await loginUsecase(params!);

        await delay(seconds: 2);

        failureOrSuccess!.fold((failure) async {
          emit(AuthFailure());
        }, (success) async {
          if (success.status) {
            emit(AuthSuccess(success));

            if (await setSharedPrefes(success)) {
              GlobalWidget.userId = success.id.toString();
            }
          } else {
            emit(AuthWrong());
          }
        });
        await delay(seconds: 2);
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure());
        await delay(seconds: 2);
        emit(AuthInitial());
      }
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    _prefs = await SharedPreferences.getInstance();
    if (formValidationCubit.state.isPasswordValid &&
        formValidationCubit.state.isUsernameValid) {
      try {
        emit(AuthLoading());
        params = AuthRequestParams(
            username: event.username, password: event.password);
        failureOrSuccess = await signUpUsecase(params!);

        await delay(seconds: 2);

        failureOrSuccess!.fold((failure) async {
          emit(AuthFailure());
        }, (success) async {
          if (success.status) {
            emit(AuthSuccess(success));

            if (await setSharedPrefes(success)) {
              GlobalWidget.userId = success.id.toString();
            }
          } else {
            emit(AuthWrong());
          }
        });
        await delay(seconds: 2);
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure());
        await delay(seconds: 2);
        emit(AuthInitial());
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
