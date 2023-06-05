import '../../core/params/titles_post_params.dart';
import '../../data/model/title_posts_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/model/home_model.dart';

abstract class TitlesPostRepository {
  Future<Either<Failure, TitlePostsModel>> getTitlePosts(
    TitlesPostRequestParams params,
  );
}
