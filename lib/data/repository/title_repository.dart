import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class TitleRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<TitleModel> getTitle(String page,String category_id) async {
    final response =
        await _apiProvider.get('titles_api.php?page=${page}&category_id=${category_id}');
    print('titles_api.php?page=${page}&category_id=${category_id}');
    return TitleModel.fromJson(response);
  }
}
