import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/data.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHome();
}
