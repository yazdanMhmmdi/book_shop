class AuthModel {
  late final int id;
  late final String status;

  AuthModel({required this.id, required this.status});

  factory AuthModel.fromJson(Map<String, dynamic> parsedJson) {
    return AuthModel(
        status: parsedJson["status"].toString(),
        id: int.parse(parsedJson['id']));
  }
}
