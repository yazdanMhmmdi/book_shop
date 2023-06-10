import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../core/network/remote_api_service.dart';
import '../../core/params/titles_post_params.dart';
import '../../domain/repositories/titles_post_repository.dart';
import '../model/title_posts_model.dart';

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
