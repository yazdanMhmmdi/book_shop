import 'dart:async';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/widgets/background_shapes.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InternetDisconnected) {
                setState(() {
                  backgroundColor = Colors.white;
                });
              } else if (state is InternetConnected) {
                setState(() {
                  backgroundColor = IColors.green;
                });
                Timer(Duration(seconds: 3), () async {
                  if (await getSharedPrefs() == "") {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    Navigator.pushNamed(context, '/home');
                  }
                });
              } else if (state is InternetLoading) {
                return Container();
              }
            },
            builder: (context, state) {
              if (state is InternetConnected) {
                return Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/logo_n_text.png",
                        width: 96,
                        height: 109,
                      ),
                    ),
                    BackgroundShapes(),
                  ],
                );
              } else if (state is InternetDisconnected) {
                return NoNetworkFlare();
              } else {
                return NoNetworkFlare();
              }
            },
          ),
        ],
      )),
    );
  }

  Future<String> getSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = "";

    id = (prefs.getString('id') == null ? "" : prefs.getString('id'));
    print('sharedPrefs : $id');
    return id;
  }
}
