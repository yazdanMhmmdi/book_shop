import 'package:book_shop/data/model/chat_model.dart';
import 'package:book_shop/networking/api_provider.dart';

class ChatRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<ChatModel> getChatMessages(
      String userId, String bookId, String page) async {
    final response = await _apiProvider.get(
        '/chat_messages_api.php?user_id=$userId&page=$page&book_id=$bookId');
    return ChatModel.fromJson(response);
  }

  socketInitial() async {}
}
