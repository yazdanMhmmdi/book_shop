
class ChatModel {
  ChatModel({
    required this.chats,
    required this.data,
  });
  late final List<Chats> chats;
  late final Data data;

  ChatModel.fromJson(Map<String, dynamic> json) {
    chats = List.from(json['chats']).map((e) => Chats.fromJson(e)).toList();
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['chats'] = chats.map((e) => e.toJson()).toList();
    _data['data'] = data.toJson();
    return _data;
  }
}

class Chats {
  Chats({
    required this.id,
    required this.message,
    required this.fromId,
    required this.userId,
    required this.bookId,
    required this.conversationId,
    this.date,
    required this.isRead,
    this.time,
  });

  late final String id;
  late final String message;
  late final String fromId;
  late final String userId;
  late final String bookId;
  late final String conversationId;
  late var date;
  late final String isRead;
  late var time;

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    fromId = json['from_id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    conversationId = json['conversation_id'];
    date = null;
    isRead = json['is_read'];
    time = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['0'] = 0;
    _data['1'] = 1;
    _data['2'] = 2;
    _data['3'] = 3;
    _data['4'] = 4;
    _data['5'] = 5;
    _data['6'] = 6;
    _data['7'] = 7;
    _data['8'] = 8;
    _data['id'] = id;
    _data['message'] = message;
    _data['from_id'] = fromId;
    _data['user_id'] = userId;
    _data['book_id'] = bookId;
    _data['conversation_id'] = conversationId;
    _data['date'] = date;
    _data['is_read'] = isRead;
    _data['time'] = time;
    return _data;
  }
}

class Data {
  Data({
    required this.oprationType,
    required this.totalPages,
    required this.currentPage,
    required this.offsetPage,
  });
  late final String oprationType;
  late final int totalPages;
  late final String currentPage;
  late final int offsetPage;

  Data.fromJson(Map<String, dynamic> json) {
    oprationType = json['opration_type'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    offsetPage = json['offset_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['opration_type'] = oprationType;
    _data['total_pages'] = totalPages;
    _data['current_page'] = currentPage;
    _data['offset_page'] = offsetPage;
    return _data;
  }
}
