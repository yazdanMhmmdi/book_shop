class AuthModel {
  int id;
  String username;
  String password;
  String status;

  AuthModel({this.id, this.password, this.username, this.status});

  factory AuthModel.fromJson(Map<String, dynamic> parsedJson) {
    return AuthModel(
      password: parsedJson["password"].toString(),
      username: parsedJson["username"].toString(),
      status: parsedJson["status"].toString(),
    );
  }
}
