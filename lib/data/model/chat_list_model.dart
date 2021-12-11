class ChatListModel {
  ChatListModel({
    required this.chatsList,
    required this.data,
  });
  late final List<ChatsList> chatsList;
  late final Data data;
  
  ChatListModel.fromJson(Map<String, dynamic> json){
    chatsList = List.from(json['chatsList']).map((e)=>ChatsList.fromJson(e)).toList();
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['chatsList'] = chatsList.map((e)=>e.toJson()).toList();
    _data['data'] = data.toJson();
    return _data;
  }
}

class ChatsList {
  ChatsList({

    required this.bookIdNum,
    required this.userId,
    required this.fromId,
    required this.id,
    required this.newMessageCount,
    required this.pictureThumb,
    required this.name,
    required this.writer,
    required this.price,
    required this.voteCount,
  });

  late final String bookIdNum;
  late final String userId;
  late final String fromId;
  late final String id;
  late final String newMessageCount;
  late final String pictureThumb;
  late final String name;
  late final String writer;
  late final String price;
  late final String voteCount;
  
  ChatsList.fromJson(Map<String, dynamic> json){

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
    final _data = <String, dynamic>{};
    _data['0'] = 0;
    _data['1'] = 1;
    _data['2'] = 2;
    _data['3'] = 3;
    _data['4'] = 4;
    _data['book_id_num'] = bookIdNum;
    _data['user_id'] = userId;
    _data['from_id'] = fromId;
    _data['id'] = id;
    _data['new_message_count'] = newMessageCount;
    _data['picture_thumb'] = pictureThumb;
    _data['name'] = name;
    _data['writer'] = writer;
    _data['price'] = price;
    _data['vote_count'] = voteCount;
    return _data;
  }
}

class Data {
  Data({
    required this.totalPages,
    required this.currentPage,
    required this.offsetPage,
  });
  late final int totalPages;
  late final String currentPage;
  late final int offsetPage;
  
  Data.fromJson(Map<String, dynamic> json){
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    offsetPage = json['offset_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_pages'] = totalPages;
    _data['current_page'] = currentPage;
    _data['offset_page'] = offsetPage;
    return _data;
  }
}