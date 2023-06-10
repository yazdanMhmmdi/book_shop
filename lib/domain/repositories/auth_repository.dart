import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/auth_params.dart';
import '../../data/data.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login(AuthRequestParams params);
  Future<Either<Failure, AuthModel>> signUp(AuthRequestParams params);
}
