import 'package:book_shop/core/params/account_params.dart';
import 'package:book_shop/core/params/basket_params.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/data/model/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/auth_params.dart';
import '../../data/model/function_response_model.dart';

abstract class AccountRepository {
  Future<Either<Failure, UserModel>> getAccount(AccountRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> editAccount(
      AccountRequestParams params);
}
