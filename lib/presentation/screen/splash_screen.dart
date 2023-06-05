import '../../logic/cubit/ckeck_update_cubit.dart';
import '../widgets/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/logic.dart';
import '../../constants/constants.dart';

import '../../injector.dart';
import '../widgets/single_button_dialog_widget.dart';
import '../widgets/update_dialog.dart';

class SplashScreen extends StatelessWidget {
  late SplashCubit _splashCubit;
  late CheckUpdateCubit _updateCubit;

  @override
  Widget build(BuildContext context) {
    _splashCubit = BlocProvider.of<SplashCubit>(context);
    _updateCubit = BlocProvider.of<CheckUpdateCubit>(context);

    _splashCubit.intialUserIdFromPrefs();
    // data();
    return MultiBlocListener(
      listeners: [
        BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashIsGuest) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/intro', (e) => false);
            } else if (state is SplashIsUser) {
              _updateCubit.checkApkUpdate();
            }
          },
        ),
        BlocListener<CheckUpdateCubit, CheckUpdateState>(
            listener: (context, state) {
          if (state is CheckUpdateSuccessNoUpdate) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (e) => false);
          } else if (state is CheckUpdateSuccessUpdateAvailable) {
            showGeneralDialog(
              pageBuilder: (_, __, ___) {
                return UpdateDialog(
                  onTap: () {
                    // _basketBloc.add(AddBasket(book_id: id));
                    _updateCubit.getUpdate(state.updateAppModel.apk!);
                  },
                );
              },
              context: context,
            );
          }
        })
      ],
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetConnected) {
            return Scaffold(
              backgroundColor: IColors.green,
              body: Stack(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.logo,
                          width: 96,
                          height: 109,
                        ),
                      ),
                      BackgroundShapes(),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is InternetDisconnected) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: NoNetworkFlare()));
          } else {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: NoNetworkFlare()));
          }
        },
      ),
    );
  }
}
