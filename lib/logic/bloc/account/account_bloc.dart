import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/account_response_model.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/logic/cubit/cubit.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required this.formValidationCubit}) : super(AccountInitial()) {
    on<GetDefaultEvent>(_getDefault);
    on<EditEvent>(_edit);
  }
  String username = "", password = "";
  late AccountModel _accountModel;
  final AccountRepository _accountRepository = AccountRepository();
  late FormValidationCubit formValidationCubit;

  Future<void> _getDefault(
      GetDefaultEvent event, Emitter<AccountState> emit) async {
    emit(AccountLoading(username: username, password: password));
    print("AccountLoading");
    try {
      _accountModel =
          await _accountRepository.getUsernameAndPassword(GlobalWidget.userId);
      username = _accountModel.account.username;
      password = _accountModel.account.password;

      emit(AccountSuccess(username: username, password: password));
      print("AccountSuccess");
    } catch (_) {
      print("AccountFailure ${_}");
      emit(AccountFailure(username: username, password: password));
    }
  }

  Future<void> _edit(EditEvent event, Emitter<AccountState> emit) async {
    if (formValidationCubit.state.isUsernameValid &&
        formValidationCubit.state.isPasswordValid) {
      emit(AccountEditInitial(username: username, password: password));
      print("AccountEditInitial");
      emit(AccountEditLoading(username: username, password: password));
      print("AccountEditLoading");
      await Future.delayed(const Duration(seconds: 2));

      try {
        AccountResponseModel _responseModel = await _accountRepository.edit(
            GlobalWidget.userId, event.newUsername, event.newPassword);

        if (_responseModel.status == "success") {
          //update model in edit event
          username = _responseModel.account.username;
          password = _responseModel.account.password;

          print("AccountEditSuccess");
          emit(AccountEditSuccess(
            username: username,
            password: password,
          ));
          await Future.delayed(const Duration(seconds: 2));
          print("AccountEditInitial");
          emit(AccountEditInitial(username: username, password: password));
        } else {
          emit(AccountEditFailure(username: username, password: password));
          print("AccountEditFailure");

          await Future.delayed(const Duration(seconds: 2));
          emit(AccountEditInitial(username: username, password: password));
        }
      } catch (_) {
        print("AccountEditFailure ${_}");
        emit(AccountEditFailure(username: username, password: password));
        await Future.delayed(const Duration(seconds: 2));
        emit(AccountEditInitial(username: username, password: password));
      }
    }
  }
}


/*
 else if (event is EditEvent) {
       
      }

      */
