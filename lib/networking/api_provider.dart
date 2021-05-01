import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  static const String URL_IP = "yazdanmohammadi.ir"; //yazdanmohammadi.ir
  final String _BASE_URL = "https://$URL_IP/book_shop/api/"; //http

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
      print("json decoding failure");
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
