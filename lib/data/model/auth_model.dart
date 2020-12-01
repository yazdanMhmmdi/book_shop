class AuthModel {
  int id;
  String status;

  AuthModel({this.id, this.status});

  factory AuthModel.fromJson(Map<String, dynamic> parsedJson) {
    return AuthModel(
        status: parsedJson["status"].toString(),
        id: int.parse(parsedJson['id']));
  }
}
