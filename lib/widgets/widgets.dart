import 'package:flutter/material.dart';

int bgColor = 0xffA2DE96;
int btnColor = 0xff3CA59E;
int txfColor = 0xff3CA59E;
int icoColor = 0xff6E717A;

Widget backgroundShapes() {
  double width = 150;
  double height = 200;
  Future.delayed(Duration(seconds: 1), () {
    width = 200;
    height = 250;
    print('Delat $width');
  });
  return Stack(
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
          top: 12, left: 12, child: Image.asset("assets/images/circle_3.png")),
      Positioned(
          top: 0, right: 0, child: Image.asset("assets/images/circle_4.png")),
    ],
  );
}

Widget registrationTextField(var icon, var text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(txfColor).withOpacity(0.15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              IconButton(
                  icon: Icon(icon, color: Color(icoColor)), onPressed: () {}),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "IranSans",
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: '$text'),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: 'نام کاربری'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget registrationButton() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        color: Color(btnColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () => print('ss'),
            child: Center(
                child: Text(
              'تایید',
              style: TextStyle(color: Colors.white),
            ))),
      ),
    ),
  );
}
