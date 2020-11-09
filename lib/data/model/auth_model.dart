class AuthModel {
  int id;
  String username;
  String password;
  String status;

  AuthModel({this.id, this.password, this.username, this.status});

  factory AuthModel.fromJson(Map<String, dynamic> parsedJson) {
    return AuthModel(
      id: parsedJson['id'],
      password: parsedJson['password'],
      username: parsedJson['username'],
      status: parsedJson['status'],
    );
  }
}