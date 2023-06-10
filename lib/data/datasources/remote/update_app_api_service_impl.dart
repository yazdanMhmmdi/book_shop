import 'package:retrofit/retrofit.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/update_app_api_service.dart';
import '../../../core/params/update_app_params.dart';
import '../../../domain/entities/book_shop_client.dart';
import '../../model/update_app_model.dart';

class UpdateAppApiServiceImpl implements UpdateAppApiService {
  BookShopClient? bookShopClient;
  UpdateAppApiServiceImpl(this.bookShopClient);
  @override
  Future<UpdateAppModel> getUpdate(UpdateAppRequestParams params) async {
    try {
      final HttpResponse response =
          await bookShopClient!.getUpdate(platform: params.platform!);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "gethome->update_app_api_service: ${error.toString()}");
    }
  }
}
