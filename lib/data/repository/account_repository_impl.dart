import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/remote_api_service.dart';
import '../../core/params/account_params.dart';
import '../../domain/repositories/account_repository.dart';
import '../model/function_response_model.dart';
import '../model/user_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RemoteApiService homeApiService;
  AccountRepositoryImpl(this.homeApiService);
  @override
  Future<Either<Failure, UserModel>> getAccount(
      AccountRequestParams params) async {
    try {
      final response = await homeApiService.getAccount(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, FunctionResponseModel>> editAccount(
      AccountRequestParams params) async {
    try {
      final response = await homeApiService.editAccount(params);
      if (response.status == true) {
        return Right(response);
      } else {
        return Left(SameUsernameFailure(message: response.errorMessage));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  // Future<AccountModel> getUsernameAndPassword(String userId) async {
  //   final response = await _apiProvider.get('account_api.php?user_id=$userId');
  //   return AccountModel.fromJson(response);
  // }

  // Future<AccountResponseModel> edit(
  //     String userId, String newUsername, String newPassword) async {
  //   final response = await _apiProvider.get(
  //       'edit_username_password_api.php?user_id=$userId&newUsername=$newUsername&newPassword=$newPassword');
  //   return AccountResponseModel.fromJson(response);
}
