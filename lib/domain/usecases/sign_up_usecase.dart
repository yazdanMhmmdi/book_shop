import 'package:book_shop/core/error/failure.dart';
import 'package:book_shop/core/params/auth_params.dart';
import 'package:book_shop/core/usecase/usecase.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase implements UseCase<AuthModel, AuthRequestParams> {
  SignUpUsecase(this._repository);
  AuthRepository? _repository;

  @override
  Future<Either<Failure, AuthModel>> call(AuthRequestParams params) async {
    return await _repository!.signUp(params);
  }
}
