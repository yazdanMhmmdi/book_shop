import '../../core/params/account_params.dart';
import '../../core/params/basket_params.dart';
import '../../data/model/user_model.dart';
import '../repositories/account_repository.dart';
import '../repositories/basket_repository.dart';
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
