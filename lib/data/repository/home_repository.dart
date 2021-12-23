import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/networking/networking.dart';

class HomeRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<HomeModel> fetchHome(String username) async {
    final response =
        await _apiProvider.get('home_api.php?username=${username}');

    return HomeModel.fromJson(response);
  }
}
