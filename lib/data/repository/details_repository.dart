import 'package:book_shop/data/model/details_model.dart';
import 'package:book_shop/networking/networking.dart';

class DetailsRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<DetailsModel> getDetails(String postId) async {
    final response = await _apiProvider.get('/details_api.php?post_id=$postId');
    return DetailsModel.fromJson(response);
  }
}
