import 'package:flutter/material.dart';

int bgColor = 0xffA2DE96;
int btnColor = 0xff3CA59E;
int txfColor = 0xff3CA59E;
int icoColor = 0xff6E717A;

Widget backgroundShapes() {
  double width = 150;
  double height = 200;
  String heroTag = "background_shape";
  Future.delayed(Duration(seconds: 1), () {
    width = 200;
    height = 250;
    // print('Delat $width');
  });
  return Hero(
    tag: heroTag,
    child: Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 0,
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: width,
                height: height,
                child: Image.asset("assets/images/circle_1.png"))),
        Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/circle_2.png")),
        Positioned(
            top: 12,
            left: 12,
            child: Image.asset("assets/images/circle_3.png")),
        Positioned(
            top: 0, right: 0, child: Image.asset("assets/images/circle_4.png")),
      ],
    ),
  );
}





Widget whiteTextField() {}
