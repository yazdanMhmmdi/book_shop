import 'package:book_shop/core/network/remote_api_service.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/book_shop_client.dart';

class RemoteApiServiceImpl extends RemoteApiService {
  BookShopClient? bookShopClient;
  RemoteApiServiceImpl(this.bookShopClient);
  @override
  Future<HomeModel> getHome() async {
    try {
      final HttpResponse response = await bookShopClient!.fetchHome();

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(message: error.toString());
    }
  }
}
