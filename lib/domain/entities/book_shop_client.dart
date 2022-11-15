import 'package:book_shop/data/data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/utils/constants.dart';

part 'book_shop_client.g.dart';

@RestApi(baseUrl: kBaseApiUrl)
abstract class BookShopClient {
  factory BookShopClient(Dio dio, {String baseUrl}) = _BookShopClient;

  @GET('/home_api.php?username=sss')
  Future<HttpResponse<HomeModel>> fetchHome();

  // @GET('/movie/upcoming')
  // Future<HttpResponse<UpcomingMoviesResponseModel>> fetchUpcomingMovies({
  //   @Query("page") required String page,
  //   @Query("language") required String language,
  //   @Query("api_key") required String apiKey,
  // });
}
