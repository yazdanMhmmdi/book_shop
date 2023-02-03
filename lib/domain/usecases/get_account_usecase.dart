import 'package:book_shop/core/params/account_params.dart';
import 'package:book_shop/core/params/basket_params.dart';
import 'package:book_shop/data/model/user_model.dart';
import 'package:book_shop/domain/repositories/account_repository.dart';
import 'package:book_shop/domain/repositories/basket_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/basket_model.dart';

class GetAccountUsecase implements UseCase<UserModel, AccountRequestParams> {
  GetAccountUsecase(this._repository);
  AccountRepository? _repository;

  @override
  Future<Either<Failure, UserModel>> call(params) async {
    return await _repository!.getAccount(params);
  }
}