import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  static const String URL_IP = "192.168.1.4"; //yazdanmohammadi.ir
  final String _BASE_URL = "http://$URL_IP/book_shop/v1.1/api/"; //http
  static const String WEB_SOCKET = "ws://$URL_IP:8080/book_shop/v1.1/api/server/websocket_api.php";
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(_BASE_URL + url));
      return await decodeResponse(response);
    } catch (_) {
      print('connection failure $_BASE_URL' + url);
    }
  }

  dynamic decodeResponse(response) {
    try {
      return json.decode(response.body);
    } catch (_) {
      print("json decoding failure :: ${_.toString()}");
    }
  }
  // decodeResponse(bool utf8Support, response) {
  //   if (utf8Support) {
  //     return json.decode(utf8.decode(response.bodyBytes));
  //   } else {
  //     return json.decode(response.body.toString());
  //   }
  // }
}
