class AccountModel {
  late final Account account;

  AccountModel({required this.account});

  AccountModel.fromJson(Map<String, dynamic> json) {
    account = json['account'] = Account.fromJson(json['account']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    return data;
  }
}

class Account {
  late final String id;
  late final String username;
  late final String password;
  late final String picture;
  late final String thumbPicture;

  Account(
      {required this.id,
      required this.username,
      required this.password,
      required this.picture,
      required this.thumbPicture});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    username = json['username'] ?? "";
    password = json['password'] ?? "";
    picture = json['picture'] ?? "";
    thumbPicture = json['thumb_picture'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['picture'] = this.picture;
    data['thumb_picture'] = this.thumbPicture;
    return data;
  }
}
