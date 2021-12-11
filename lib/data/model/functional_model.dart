class FunctionalModel {
  FunctionalModel({
    required this.error,
    required this.errorMessage,
    required this.status,
  });
  late final String error;
  late final String errorMessage;
  late final String status;

  FunctionalModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['error_message'] = errorMessage;
    _data['status'] = status;
    return _data;
  }
}
