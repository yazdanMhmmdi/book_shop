import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/remote_api_service.dart';
import '../../core/params/auth_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../model/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteApiService homeApiService;
  AuthRepositoryImpl(this.homeApiService);
  @override
  Future<Either<Failure, AuthModel>> login(AuthRequestParams params) async {
    try {
      final response = await homeApiService.login(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signUp(AuthRequestParams params) async {
    try {
      final response = await homeApiService.signUp(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
