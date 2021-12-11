class ResponseModel {
  ResponseModel({
    required this.status,
    required this.body,
  });
  late final String status;
  late final String body;

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['body'] = body;
    return _data;
  }
}
