import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/strings.dart';
import '../../../core/error/failure.dart';
import '../../../core/params/account_params.dart';
import '../../../data/model/function_response_model.dart';
import '../../../data/model/user_model.dart';
import '../../../domain/usecases/edit_account_usecase.dart';
import '../../../domain/usecases/get_account_usecase.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../cubit/cubit.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required this.formValidationCubit,
    required this.getAccountUsecase,
    required this.editAccountUsecase,
  }) : super(AccountInitial()) {
    on<GetDefaultEvent>(_getDefault);
    on<EditEvent>(_edit);
  }
  String username = "", password = "";
  late FormValidationCubit formValidationCubit;
  GetAccountUsecase getAccountUsecase;
  EditAccountUsecase editAccountUsecase;

  Future<void> _getDefault(
      GetDefaultEvent event, Emitter<AccountState> emit) async {
    emit(AccountLoading(username: username, password: password));
    print("AccountLoading");
    try {
      AccountRequestParams params = AccountRequestParams();
      params.userId = GlobalWidget.userId;
      Either<Failure, UserModel> failureOrSuccess =
          await getAccountUsecase(params);

      failureOrSuccess.fold((failure) {
        emit(AccountFailure(username: username, password: password));
      }, (success) {
        username = success.username;
        password = success.password;
        emit(AccountSuccess(
            username: success.username, password: success.password));
      });
      print("AccountSuccess");
    } catch (_) {
      print("AccountFailure ${_}");
      emit(AccountFailure(username: username, password: password));
    }
  }

  Future<void> _edit(EditEvent event, Emitter<AccountState> emit) async {
    if (formValidationCubit.state.isUsernameValid &&
        formValidationCubit.state.isPasswordValid) {
      AccountRequestParams params = AccountRequestParams();
      params.userId = GlobalWidget.userId;
      params.username = event.newUsername;
      params.password = event.newPassword;

      emit(AccountEditInitial(username: username, password: password));
      print("AccountEditInitial");
      emit(AccountEditLoading(username: username, password: password));
      print("AccountEditLoading");
      await Future.delayed(const Duration(seconds: 2));

      try {
        Either<Failure, FunctionResponseModel> failureOrSuccess =
            await editAccountUsecase(params);

        failureOrSuccess.fold((left) async {
          emit(AccountEditFailure(username: username, password: password));
          //delay text error in under editable text to sync with AccountEditInital state
          if (left is SameUsernameFailure) {
            Timer(const Duration(seconds: 2), () {
              formValidationCubit
                  .usernameIsAlreadyExists(Strings.thisUsernameAlreadyExists);
            });
          }
          print("AccountEditFailure");
        }, (right) async {
          //update model in edit event
          print("AccountEditSuccess");
          emit(AccountEditSuccess(
            username: username,
            password: password,
          ));
          //show username under avater
          username = event.newUsername;
          password = event.newPassword;
        });
      } catch (_) {
        print("AccountEditFailure ${_}");
        emit(AccountEditFailure(username: username, password: password));
      }
      await Future.delayed(const Duration(seconds: 2));
      print("AccountEditInitial");
      emit(AccountEditInitial(
          username: params.username, password: params.password));
    }
  }
}


/*
 else if (event is EditEvent) {
       
      }

      */
