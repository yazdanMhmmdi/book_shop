import 'package:book_shop/data/model/chat_list_model.dart';
import 'package:book_shop/data/model/details_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class ChatListRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<ChatListModel> getChatList(String userId, String page) async {
    final response =
        await _apiProvider.get('/chat_list_api.php?user_id=$userId&page=$page');
    return ChatListModel.fromJson(response);
  }
}
