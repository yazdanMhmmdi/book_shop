import 'package:book_shop/data/model/account_model.dart';
import 'package:book_shop/data/model/account_response_model.dart';
import 'package:book_shop/data/model/response_model.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountRepository {
  ApiProvider _apiProvider = new ApiProvider();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<AccountModel> getUsernameAndPassword(String userId) async {
    final response =
        await _apiProvider.get('account_api.php?user_id=${userId}');
    return AccountModel.fromJson(response);
  }

  Future<AccountResponseModel> edit(
      String userId, String newUsername, String newPassword) async {
    final response = await _apiProvider.get(
        'edit_username_password_api.php?user_id=${userId}&newUsername=${newUsername}&newPassword=${newPassword}');
    return AccountResponseModel.fromJson(response);
  }

  void deletePrefs() async {
    SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
