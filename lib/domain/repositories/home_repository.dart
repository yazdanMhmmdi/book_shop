import 'package:book_shop/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHome();
}
