import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/account_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());
  AccountRepository _accountRepository = new AccountRepository();
  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is GetDefaultEvent) {
      yield AccountInitial();
      print('AccountInitial');
      yield AccountLoading();

      print('AccountLoading');
      try {
        AccountModel _accountModel =
            await _accountRepository.getUsernameAndPassword(event.userId);
        yield AccountSuccess(_accountModel);
        print('AccountSuccess');
      } catch (_) {
        yield AccountFailure();
        print('AccountFailure');
      }
    } else if (event is EditEvent) {
      yield AccountInitial();
      yield AccountLoading();
      AccountModel _accountModel = new AccountModel();
      yield AccountSuccess(_accountModel);
      yield AccountFailure();
    }
  }
}
