import 'package:book_shop/core/error/failure.dart';
import 'package:book_shop/core/network/remote_api_service.dart';
import 'package:book_shop/core/params/titles_post_params.dart';
import 'package:book_shop/data/datasources/remote/book_shop_api_service.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/data/model/title_posts_model.dart';
import 'package:book_shop/domain/repositories/home_repository.dart';
import 'package:book_shop/domain/repositories/titles_post_repository.dart';
import 'package:book_shop/networking/networking.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';

class TitlePostsRepositoryImpl implements TitlesPostRepository {
  final RemoteApiService remoteApiService;
  TitlePostsModel? response;
  TitlePostsRepositoryImpl(this.remoteApiService);

  @override
  Future<Either<Failure, TitlePostsModel>> getTitlePosts(
      TitlesPostRequestParams params) async {
    try {
      response = await remoteApiService.getTitlePost(params);

      return Right(response!);
    } on ServerException catch (error) {
      return Left(ServerFailure(
          message: "TitlePostsRepositoryImpl : ${error.message.toString()}"));
    }
  }
}
