class AccountModel {
  Account account;

  AccountModel({this.account});

  AccountModel.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    return data;
  }
}

class Account {
  String s0;
  String s1;
  String s2;
  String s3;
  String s4;
  String id;
  String username;
  String password;
  String picture;
  String thumbPicture;

  Account(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.id,
      this.username,
      this.password,
      this.picture,
      this.thumbPicture});

  Account.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    id = json['id'];
    username = json['username'];
    password = json['password'];
    picture = json['picture'];
    thumbPicture = json['thumb_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['picture'] = this.picture;
    data['thumb_picture'] = this.thumbPicture;
    return data;
  }
}
