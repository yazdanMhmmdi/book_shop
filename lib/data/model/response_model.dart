class ResponseModel {
  String status;
  String body;

  ResponseModel({this.status, this.body});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['body'] = this.body;
    return data;
  }
}