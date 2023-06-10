import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/params/update_app_params.dart';
import '../../core/utils/package_info_provider.dart';
import '../../data/model/update_app_model.dart';
import '../../domain/usecases/get_update_usecase.dart';

part 'ckeck_update_state.dart';

class CheckUpdateCubit extends Cubit<CheckUpdateState> {
  CheckUpdateCubit(
      {required this.getUpdateUsecase, required this.packageInfoProvider})
      : super(CheckUpdateLoading());
  GetUpdateUsecase getUpdateUsecase;
  PackageInfoProvider packageInfoProvider;
  UpdateAppRequestParams _updateAppRequestParams = UpdateAppRequestParams();

  void checkApkUpdate(String route) async {
    _updateAppRequestParams.platform = "Android";
    final failureOrPosts = await getUpdateUsecase(_updateAppRequestParams);
    emit(await failureOrPosts.fold(
      (failure) => CheckUpdateFailure(),
      (update) {
        // return UpdateSuc(posts);
        if (packageInfoProvider.getAppVersion() == update.version) {
          return CheckUpdateSuccessNoUpdate(route: route);
        } else {
          return CheckUpdateSuccessUpdateAvailable(
              updateAppModel: update, route: route);
        }
      },
    ));
  }

  void getUpdate(String url) async {
    await launch(url);
  }
}
