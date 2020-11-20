import 'package:book_shop/data/model/details_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class DetailsRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<DetailsModel> getDetails(String post_id) async {
    final response =
        await _apiProvider.get('/details_api.php?post_id=${post_id}');
    return DetailsModel.fromJson(response);
  }
}
