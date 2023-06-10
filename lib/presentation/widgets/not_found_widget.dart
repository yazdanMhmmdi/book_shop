// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../animation/animation.dart';
import 'widgets.dart';

class NotFoundWidget extends StatelessWidget {
  String text;
  NotFoundWidget({required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NotFoundFlare(),
          const SizedBox(
            height: 8,
          ),
          FadeInAnimation(
            0.5,
            Text(
              text,
              style: const TextStyle(
                  fontFamily: "IranSans", fontSize: 18, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
