import '../../core/network/update_app_api_service.dart';
import '../model/update_app_model.dart';
import '../../core/params/update_app_params.dart';
import '../../core/error/failure.dart';
import '../../domain/repositories/update_app_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';

class UpdateAppRepositoryImpl implements UpdateAppRepository {
  final UpdateAppApiService updateAppApiService;
  UpdateAppModel? response;
  UpdateAppRepositoryImpl(this.updateAppApiService);
  @override
  Future<Either<Failure, UpdateAppModel>> getUpdate(
      UpdateAppRequestParams params) async {
    try {
      response = await updateAppApiService.getUpdate(params);

      return Right(response!);
    } on ServerException catch (error) {
      return Left(ServerFailure(
          message: "UpdateAppRepoImpl : ${error.message.toString()}"));
    }
  }
}
