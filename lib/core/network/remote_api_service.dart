import 'package:book_shop/data/data.dart';
import 'package:book_shop/data/model/title_posts_model.dart';

import '../params/auth_params.dart';
import '../params/titles_post_params.dart';

abstract class RemoteApiService {
  Future<HomeModel> getHome();
  Future<TitlePostsModel> getTitlePost(TitlesPostRequestParams params);
  Future<AuthModel> login(AuthRequestParams params);
  Future<AuthModel> signUp(AuthRequestParams params);
}
