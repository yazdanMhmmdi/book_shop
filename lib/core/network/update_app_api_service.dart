import '../../data/model/update_app_model.dart';
import '../params/update_app_params.dart';

abstract class UpdateAppApiService {
  Future<UpdateAppModel> getUpdate(UpdateAppRequestParams params);
}
