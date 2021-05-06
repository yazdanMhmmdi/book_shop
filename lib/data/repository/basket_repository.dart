import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class ChatListRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<BasketModel> getBasket(String user_id, String page) async {
    final response = await _apiProvider
        .get('/basket_api.php?user_id=${user_id}&page=${page}');
    return BasketModel.fromJson(response);
  }
}