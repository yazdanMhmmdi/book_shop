import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/basket_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/function_response_model.dart';
import '../repositories/basket_repository.dart';

class DeleteBasketUsecase
    implements UseCase<FunctionResponseModel, BasketRequestParams> {
  DeleteBasketUsecase(this._repository);
  BasketRepository? _repository;

  @override
  Future<Either<Failure, FunctionResponseModel>> call(
      BasketRequestParams params) async {
    return await _repository!.deleteBasket(params);
  }
}
