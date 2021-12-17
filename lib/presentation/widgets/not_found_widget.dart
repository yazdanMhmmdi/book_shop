import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/not_found_flare.dart';
import 'package:flutter/material.dart';

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
          SizedBox(
            height: 8,
          ),
          FadeInAnimation(
            0.5,
            Text(
              '${text}',
              style: TextStyle(
                  fontFamily: "IranSans", fontSize: 18, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
