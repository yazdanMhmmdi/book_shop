import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/update_app_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/update_app_model.dart';
import '../repositories/update_app_repository.dart';

class GetUpdateUsecase
    implements UseCase<UpdateAppModel, UpdateAppRequestParams> {
  GetUpdateUsecase(this._repository);
  UpdateAppRepository? _repository;

  @override
  Future<Either<Failure, UpdateAppModel>> call(
      UpdateAppRequestParams params) async {
    return await _repository!.getUpdate(params);
  }
}
