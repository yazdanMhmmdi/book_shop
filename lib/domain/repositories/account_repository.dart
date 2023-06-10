import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/account_params.dart';
import '../../data/model/function_response_model.dart';
import '../../data/model/user_model.dart';

abstract class AccountRepository {
  Future<Either<Failure, UserModel>> getAccount(AccountRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> editAccount(
      AccountRequestParams params);
}
