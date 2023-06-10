import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/basket_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/basket_model.dart';
import '../repositories/basket_repository.dart';

class GetBasketUsecase implements UseCase<BasketModel, BasketRequestParams> {
  GetBasketUsecase(this._repository);
  BasketRepository? _repository;

  @override
  Future<Either<Failure, BasketModel>> call(BasketRequestParams params) async {
    return await _repository!.getBasket(params);
  }
}
