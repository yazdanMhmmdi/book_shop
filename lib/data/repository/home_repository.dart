import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class HomeRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<HomeModel> fetchHome(String username) async {
    final response =
        await _apiProvider.get('home_api.php?username=${username}');
    print('home_api.php?username=${username}');

    return HomeModel.fromJson(response);
  }

  
}
