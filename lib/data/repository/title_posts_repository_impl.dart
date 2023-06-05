import '../../core/error/failure.dart';
import '../../core/network/remote_api_service.dart';
import '../../core/params/titles_post_params.dart';
import '../datasources/remote/book_shop_api_service.dart';
import '../model/home_model.dart';
import '../model/title_posts_model.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/repositories/titles_post_repository.dart';
import '../../networking/networking.dart';
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
