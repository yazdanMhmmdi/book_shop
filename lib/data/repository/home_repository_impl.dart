import 'package:book_shop/core/error/failure.dart';
import 'package:book_shop/core/network/remote_api_service.dart';
import 'package:book_shop/data/datasources/remote/book_shop_api_service.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/domain/repositories/home_repository.dart';
import 'package:book_shop/networking/networking.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';

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
