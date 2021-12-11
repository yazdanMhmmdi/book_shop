import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/account_model.dart';
import 'package:book_shop/data/model/response_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

AccountRepository _accountRepository = new AccountRepository();
late AccountModel _glo;

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountEvent>((event, emit) async {
      if (event is GetDefaultEvent) {
        emit(AccountInitial());
        print('AccountInitial');
        emit(AccountLoading());
        print('AccountLoading');
        try {
          AccountModel _accountModel =
              await _accountRepository.getUsernameAndPassword(
                  await _accountRepository.getSharedPrefs());
          _glo = _accountModel;
          emit(AccountSuccess(_accountModel));
          print('AccountSuccess');
        } catch (_) {
          emit(AccountFailure());
          print('AccountFailure');
        }
      } else if (event is EditEvent) {
        emit(AccountEditingLoading());
        print('AccountEditingLoading');
        try {
          ResponseModel _responseModel = await _accountRepository.edit(
              await _accountRepository.getSharedPrefs(),
              event.newUsername,
              event.newPassword);
          emit(AccountEditingSuccess(_responseModel));
          print('AccountEditingSuccess');
        } catch (_) {
          emit(AccountEditingFailure());
          print('AccountEditingFailure');
        }
      }
    });
  }
}
