import 'package:book_shop/data/data.dart';
import 'package:book_shop/data/model/title_posts_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/utils/constants.dart';
import '../../data/model/function_response_model.dart';

part 'book_shop_client.g.dart';

@RestApi(baseUrl: kBaseApiUrl)
abstract class BookShopClient {
  factory BookShopClient(Dio dio, {String baseUrl}) = _BookShopClient;

  @GET('/home_api.php?username=sss')
  Future<HttpResponse<HomeModel>> fetchHome();

  @GET('/titles_api.php')
  Future<HttpResponse<TitlePostsModel>> fetchTitlesPost(
      {@Query("page") required String page,
      @Query("category_id") required String categoryId});

  @POST('/login_api.php')
  Future<HttpResponse<AuthModel>> login({
    @Query("username") required String username,
    @Query("password") required String password,
  });
  @POST('/sign_up_api.php')
  Future<HttpResponse<AuthModel>> signUp({
    @Query("username") required String username,
    @Query("password") required String password,
  });

  @POST('/basket_api.php')
  Future<HttpResponse<BasketModel>> getBasket({
    @Query("user_id") required String userId,
    @Query("page") required String page,
  });

  @POST('/delete_basket_api.php')
  Future<HttpResponse<FunctionResponseModel>> deleteBasket({
    @Query("user_id") required String userId,
    @Query("book_id") required String bookId,
  });

  @POST('/add_basket_api.php')
  Future<HttpResponse<FunctionResponseModel>> addBasket({
    @Query("user_id") required String userId,
    @Query("book_id") required String bookId,
  });
}
