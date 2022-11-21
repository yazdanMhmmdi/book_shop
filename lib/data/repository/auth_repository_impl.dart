import 'package:book_shop/core/error/failure.dart';
import 'package:book_shop/core/params/auth_params.dart';
import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/networking/networking.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/remote_api_service.dart';
import '../../domain/repositories/auth_repository.dart';

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
