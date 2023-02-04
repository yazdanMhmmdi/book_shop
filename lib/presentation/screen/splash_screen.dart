import 'package:book_shop/presentation/widgets/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:book_shop/constants/constants.dart';

class SplashScreen extends StatelessWidget {
  late SplashCubit _splashCubit;

  @override
  Widget build(BuildContext context) {
    _splashCubit = BlocProvider.of<SplashCubit>(context);
    _splashCubit.intialUserIdFromPrefs();
    // data();
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashIsGuest) {
          Navigator.pushNamedAndRemoveUntil(context, '/intro', (e) => false);
        } else if (state is SplashIsUser) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (e) => false);
        }
      },
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
