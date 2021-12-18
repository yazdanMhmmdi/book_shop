import 'dart:async';

import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/logic/cubit/splash_cubit.dart';
import 'package:book_shop/presentation/widgets/background_shapes.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  late SplashCubit _splashCubit;

  @override
  Widget build(BuildContext context) {
    _splashCubit = BlocProvider.of<SplashCubit>(context);
    _splashCubit.intialUserIdFromPrefs();

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashIsGuest) {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (e) => false);
        } else if (state is SplashIsUser) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (e) => false);
        }
      },
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetConnected) {
            return Scaffold(
              backgroundColor: IColors.green,
              body: SafeArea(
                  child: Stack(
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
              )),
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
