import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/remote_api_service.dart';
import '../../domain/repositories/home_repository.dart';
import '../model/home_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final RemoteApiService homeApiService;

  HomeRepositoryImpl(this.homeApiService);
  @override
  Future<Either<Failure, HomeModel>> getHome() async {
    try {
      final response = await homeApiService.getHome();

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}
