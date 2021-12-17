import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/account_model.dart';
import 'package:book_shop/data/model/account_response_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

AccountRepository _accountRepository = new AccountRepository();

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    String username = "", password = "";
    AccountModel _accountModel;
    on<AccountEvent>((event, emit) async {
      if (event is GetDefaultEvent) {
        emit(AccountLoading(username: username, password: password));
        print("AccountLoading");
        try {
          _accountModel = await _accountRepository.getUsernameAndPassword(
              await _accountRepository.getSharedPrefs());
          username = _accountModel.account.username;
          password = _accountModel.account.password;

          emit(AccountSuccess(username: username, password: password));
          print("AccountSuccess");
        } catch (_) {
          print("AccountFailure ${_}");
          emit(AccountFailure(username: username, password: password));
        }
      } else if (event is EditEvent) {
        emit(AccountEditInitial(username: username, password: password));
        print("AccountInitial");

        emit(AccountEditLoading(username: username, password: password));
        print("AccountEditLoading");
        try {
          AccountResponseModel _responseModel = await _accountRepository.edit(
              await _accountRepository.getSharedPrefs(),
              event.newUsername,
              event.newPassword);

          if (_responseModel.status == "success") {
            //update model in edit event
            username = _responseModel.account.username;
            password = _responseModel.account.password;

            await Future.delayed(Duration(milliseconds: 1000));

            print("AccountSuccess");
            emit(AccountEditSuccess(
              username: username,
              password: password,
            ));
            await Future.delayed(Duration(milliseconds: 1000));
            print("AccountInitial");
            emit(AccountEditInitial(username: username, password: password));
          } else {
            emit(AccountEditFailure(username: username, password: password));
            print("AccountFailure");
          }
        } catch (_) {
          print("AccountFailure ${_}");
          emit(AccountEditFailure(username: username, password: password));
        }
      }
    });
  }
}
