// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class NewMessageNotify extends StatelessWidget {
  String newMessageCount;
  NewMessageNotify({required this.newMessageCount});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 16,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: IColors.boldGreen),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          child: Text(
            "$newMessageCount پیام جدید",
            style: const TextStyle(
                fontFamily: Strings.fontIranSans,
                fontSize: 14,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
