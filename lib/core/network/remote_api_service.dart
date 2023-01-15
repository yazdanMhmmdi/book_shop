import 'package:book_shop/core/params/account_params.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/data/model/function_response_model.dart';
import 'package:book_shop/data/model/title_posts_model.dart';
import 'package:book_shop/data/model/user_model.dart';

import '../params/auth_params.dart';
import '../params/basket_params.dart';
import '../params/titles_post_params.dart';

abstract class RemoteApiService {
  Future<HomeModel> getHome();
  Future<TitlePostsModel> getTitlePost(TitlesPostRequestParams params);
  Future<AuthModel> login(AuthRequestParams params);
  Future<AuthModel> signUp(AuthRequestParams params);

  Future<BasketModel> getBasket(BasketRequestParams params);
  Future<FunctionResponseModel> addBasket(BasketRequestParams params);
  Future<FunctionResponseModel> deleteBasket(BasketRequestParams params);

  Future<UserModel> getAccount(AccountRequestParams params);
  Future<FunctionResponseModel> editAccount(AccountRequestParams params);
}
