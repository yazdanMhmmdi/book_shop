import 'package:book_shop/constants/constants.dart';
import 'package:book_shop/core/params/basket_params.dart';
import 'package:book_shop/core/error/failure.dart';
import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/networking/networking.dart';
import 'package:book_shop/presentation/widgets/global_widget.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/remote_api_service.dart';
import '../../domain/repositories/basket_repository.dart';
import '../model/function_response_model.dart';

class BasketRepositoryImpl implements BasketRepository {
  final RemoteApiService remoteApiService;
  BasketRepositoryImpl(this.remoteApiService);
  int page = 1;

  @override
  Future<Either<Failure, FunctionResponseModel>> addBasket(
      BasketRequestParams params) async {
    try {
      final response = await remoteApiService.addBasket(params);
      if (response.status) {
        return Right(response);
      } else {
        return Left(errorHandler(response));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, FunctionResponseModel>> deleteBasket(
      BasketRequestParams params) async {
    try {
      final response = await remoteApiService.deleteBasket(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, BasketModel>> getBasket(
      BasketRequestParams params) async {
    try {
      final response = await remoteApiService.getBasket(params);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  Failure errorHandler(var response) {
    switch (response.errorMessage) {
      case 'Duplicated book.':
        return DuplicatedBookFailure(
            message: Strings.detailsAlreadyBookChoosed);
      case 'Wrong parameters.':
        return WrongParametersFailure(message: Strings.wrongParameters);
      default:
        return ServerFailure();
    }
  }
}
