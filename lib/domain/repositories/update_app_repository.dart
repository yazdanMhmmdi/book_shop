import '../../core/params/update_app_params.dart';
import '../../data/model/update_app_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

abstract class UpdateAppRepository {
  Future<Either<Failure, UpdateAppModel>> getUpdate(
      UpdateAppRequestParams params);
}
