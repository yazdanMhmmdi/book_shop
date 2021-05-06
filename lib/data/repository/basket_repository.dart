import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/data/model/functional_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class BasketRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<BasketModel> getBasket(String user_id, String page) async {
    final response = await _apiProvider
        .get('/basket_api.php?user_id=${user_id}&page=${page}');
    return BasketModel.fromJson(response);
  }

  Future<FunctionalModel> deleteBasket(String user_id, String book_id) async {
    final response = await _apiProvider
        .get('/delete_basket_api.php?user_id=${user_id}&book_id=${book_id}');
    return FunctionalModel.fromJson(response);
  }

  Future<FunctionalModel> addBasket(String user_id, String book_id) async {
    final response = await _apiProvider
        .get('/add_basket_api.php?user_id=${user_id}&book_id=${book_id}');
    return FunctionalModel.fromJson(response);
  }
}
