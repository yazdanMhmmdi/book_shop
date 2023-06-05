import 'constants.dart';

class UrlProvider {
  UrlProvider._();
  static String getAddress(String? urlAddress) {
    return kBaseUrl! + urlAddress!;
  }
}
