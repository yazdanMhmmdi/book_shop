import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class AuthRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<AuthModel> login(String username, String password) async {
    final response = await _apiProvider
        .get('login_api.php?username=$username&password=$password');
    return AuthModel.fromJson(response);
  }

  Future<AuthModel> signUp(
      {required String username, required String password}) async {
    final response = await _apiProvider
        .get('sign_up_api.php?username=$username&password=$password');
    return AuthModel.fromJson(response);
  }
}
