import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/data/model/functional_model.dart';
import 'package:book_shop/networking/networking.dart';

class BasketRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<BasketModel> getBasket(String userId, String page) async {
    final response =
        await _apiProvider.get('/basket_api.php?user_id=$userId&page=$page');
    return BasketModel.fromJson(response);
  }

  Future<FunctionalModel> deleteBasket(String userId, String bookId) async {
    final response = await _apiProvider
        .get('/delete_basket_api.php?user_id=$userId&book_id=$bookId');
    return FunctionalModel.fromJson(response);
  }

  Future<FunctionalModel> addBasket(String userId, String bookId) async {
    final response = await _apiProvider
        .get('/add_basket_api.php?user_id=$userId&book_id=$bookId');
    return FunctionalModel.fromJson(response);
  }
}
