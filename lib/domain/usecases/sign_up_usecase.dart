import '../../core/error/failure.dart';
import '../../core/params/auth_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/data.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase implements UseCase<AuthModel, AuthRequestParams> {
  SignUpUsecase(this._repository);
  AuthRepository? _repository;

  @override
  Future<Either<Failure, AuthModel>> call(AuthRequestParams params) async {
    return await _repository!.signUp(params);
  }
}
