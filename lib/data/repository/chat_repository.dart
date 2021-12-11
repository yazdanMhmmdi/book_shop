import 'package:book_shop/data/model/chat_list_model.dart';
import 'package:book_shop/data/model/chat_model.dart';
import 'package:book_shop/data/model/details_model.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:web_socket_channel/io.dart';

class ChatRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<ChatModel> getChatMessages(
      String user_id, String book_id, String page) async {
    final response = await _apiProvider.get(
        '/chat_messages_api.php?user_id=${user_id}&page=${page}&book_id=${book_id}');
    return ChatModel.fromJson(response);
  }

  socketInitial() async {}
}
