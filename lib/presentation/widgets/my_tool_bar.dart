// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyToolBar extends StatelessWidget {
  String title;
  MyToolBar({required this.title});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "IranSans",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87),
      ),
    );
  }
}
