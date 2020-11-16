import 'package:book_shop/data/model/account_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class AccountRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<AccountModel> getUsernameAndPassword(String userId) async {
    final response =
        await _apiProvider.get('account_api.php?user_id=${userId}');
    return AccountModel.fromJson(response);
  }
}
