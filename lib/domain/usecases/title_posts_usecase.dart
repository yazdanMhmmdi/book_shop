import 'package:book_shop/core/params/titles_post_params.dart';
import 'package:book_shop/data/model/title_posts_model.dart';
import 'package:book_shop/domain/repositories/titles_post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';

class TitlePostsUsecase
    implements UseCase<TitlePostsModel, TitlesPostRequestParams> {
  TitlePostsUsecase(this.repository);
  TitlesPostRepository? repository;

  @override
  Future<Either<Failure, TitlePostsModel>> call(
      TitlesPostRequestParams params) async {
    return await repository!.getTitlePosts(params);
  }
}
