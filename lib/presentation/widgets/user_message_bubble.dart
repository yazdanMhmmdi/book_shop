// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class UserMessageBubble extends StatelessWidget {
  late String message;
  UserMessageBubble({required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, top: 8),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: IColors.boldGreen,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: Strings.fontIranSans,
                  color: IColors.white90,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
