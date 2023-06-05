import '../../data/model/function_response_model.dart';
import '../repositories/account_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/account_params.dart';
import '../../core/usecase/usecase.dart';

class EditAccountUsecase
    implements UseCase<FunctionResponseModel, AccountRequestParams> {
  EditAccountUsecase(this._repository);
  AccountRepository? _repository;

  @override
  Future<Either<Failure, FunctionResponseModel>> call(params) async {
    return await _repository!.editAccount(params);
  }
}
