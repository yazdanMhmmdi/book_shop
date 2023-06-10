import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/auth_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/data.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthModel, AuthRequestParams> {
  LoginUsecase(this._repository);
  AuthRepository? _repository;

  @override
  Future<Either<Failure, AuthModel>> call(AuthRequestParams params) async {
    return await _repository!.login(params);
  }
}
