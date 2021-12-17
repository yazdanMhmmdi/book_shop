class AccountResponseModel {
  AccountResponseModel({
    required this.status,
    required this.body,
    required this.account,
  });
  late final String status;
  late final String body;
  late final Account account;

  AccountResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "failure";
    body = json['body'] ?? "";
    account = Account.fromJson(json['account']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['body'] = body;
    _data['account'] = account.toJson();
    return _data;
  }
}

class Account {
  Account({
    required this.username,
    required this.password,
  });
  late final String username;
  late final String password;

  Account.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? "";
    password = json['password'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    return _data;
  }
}
