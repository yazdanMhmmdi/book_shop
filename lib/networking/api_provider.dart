import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  static const String URL_IP = "192.168.1.4";
  final String _BASE_URL = "http://$URL_IP/Api/";


  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(url);
      responseJson = await decodeResponse(false, response);
    }
    catch(_) {
      print('connection failure');
    }
    return responseJson;
  }
  decodeResponse(bool utf8Support, response) {
    try {
      if (utf8Support) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      return json.decode(response.body.toString());
    }
    }
    catch(_) {
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