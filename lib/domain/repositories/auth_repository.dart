import 'package:book_shop/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/params/auth_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login(AuthRequestParams params);
  Future<Either<Failure, AuthModel>> signUp(AuthRequestParams params);
}
