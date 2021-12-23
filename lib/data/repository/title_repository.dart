import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/networking/networking.dart';

class TitleRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<TitleModel> getTitle(String page, String categoryId) async {
    final response = await _apiProvider
        .get('titles_api.php?page=$page&category_id=$categoryId');
    return TitleModel.fromJson(response);
  }
}
