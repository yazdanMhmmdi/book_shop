import 'dart:async';

import 'package:book_shop/presentation/widgets/widgets.dart';
import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login');
    });
    return Scaffold(
      backgroundColor: Color(0xffA2DE96),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/images/logo_n_text.png",
                width: 96,
                height: 109,
              ),
            ),
            backgroundShapes(),
          ],
        ),
      ),
    );
  }
}
