import '../model/details_model.dart';
import '../../networking/networking.dart';

class DetailsRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<DetailsModel> getDetails(String postId) async {
    final response = await _apiProvider.get('/details_api.php?post_id=$postId');
    return DetailsModel.fromJson(response);
  }
}
