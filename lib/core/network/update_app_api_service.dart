import '../params/update_app_params.dart';
import '../../data/model/update_app_model.dart';

abstract class UpdateAppApiService {
  Future<UpdateAppModel> getUpdate(UpdateAppRequestParams params);
}
