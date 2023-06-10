import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/basket_params.dart';
import '../../data/data.dart';
import '../../data/model/function_response_model.dart';

abstract class BasketRepository {
  Future<Either<Failure, BasketModel>> getBasket(BasketRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> addBasket(BasketRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> deleteBasket(BasketRequestParams params);
}
