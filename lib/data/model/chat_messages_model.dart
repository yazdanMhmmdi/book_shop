class ChatMessagesModel {
  List<Chats> chats;
  Data data;

  ChatMessagesModel({this.chats, this.data});

  ChatMessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = new List<Chats>();
      json['chats'].forEach((v) {
        chats.add(new Chats.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Chats {
  String id;
  String message;
  String fromId;
  String userId;
  String bookId;
  String conversationId;
  Null date;
  String isRead;
  Null time;

  Chats(
      {
      this.id,
      this.message,
      this.fromId,
      this.userId,
      this.bookId,
      this.conversationId,
      this.date,
      this.isRead,
      this.time});

  Chats.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    message = json['message'];
    fromId = json['from_id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    conversationId = json['conversation_id'];
    date = json['date'];
    isRead = json['is_read'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['message'] = this.message;
    data['from_id'] = this.fromId;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['conversation_id'] = this.conversationId;
    data['date'] = this.date;
    data['is_read'] = this.isRead;
    data['time'] = this.time;
    return data;
  }
}

class Data {
  int totalPages;
  String currentPage;
  int offsetPage;

  Data({this.totalPages, this.currentPage, this.offsetPage});

  Data.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    offsetPage = json['offset_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['offset_page'] = this.offsetPage;
    return data;
  }
}
