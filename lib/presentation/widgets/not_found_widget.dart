import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
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
