import 'package:book_shop/data/data.dart';

abstract class RemoteApiService {
  Future<HomeModel> getHome();
}
