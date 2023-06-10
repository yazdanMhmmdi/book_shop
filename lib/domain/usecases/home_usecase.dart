import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/home_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/home_model.dart';
import '../repositories/home_repository.dart';

class HomeUsecase implements UseCase<HomeModel, HomeParams> {
  HomeUsecase(this._repository);
  HomeRepository? _repository;

  @override
  Future<Either<Failure, HomeModel>> call(HomeParams params) async {
    return await _repository!.getHome();
  }
}
