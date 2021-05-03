class ChatListModel {
  List<ChatsList> chatsList;
  Data data;

  ChatListModel({this.chatsList, this.data});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    if (json['chatsList'] != null) {
      chatsList = new List<ChatsList>();
      json['chatsList'].forEach((v) {
        chatsList.add(new ChatsList.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatsList != null) {
      data['chatsList'] = this.chatsList.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ChatsList {

  String bookIdNum;
  String userId;
  String fromId;
  String id;
  String newMessageCount;
  String pictureThumb;
  String name;
  String writer;
  String price;
  String voteCount;

  ChatsList(
      {
      this.bookIdNum,
      this.userId,
      this.fromId,
      this.id,
      this.newMessageCount,
      this.pictureThumb,
      this.name,
      this.writer,
      this.price,
      this.voteCount});

  ChatsList.fromJson(Map<String, dynamic> json) {

    bookIdNum = json['book_id_num'];
    userId = json['user_id'];
    fromId = json['from_id'];
    id = json['id'];
    newMessageCount = json['new_message_count'];
    pictureThumb = json['picture_thumb'];
    name = json['name'];
    writer = json['writer'];
    price = json['price'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['book_id_num'] = this.bookIdNum;
    data['user_id'] = this.userId;
    data['from_id'] = this.fromId;
    data['id'] = this.id;
    data['new_message_count'] = this.newMessageCount;
    data['picture_thumb'] = this.pictureThumb;
    data['name'] = this.name;
    data['writer'] = this.writer;
    data['price'] = this.price;
    data['vote_count'] = this.voteCount;
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
