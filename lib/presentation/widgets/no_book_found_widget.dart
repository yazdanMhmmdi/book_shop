import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../animation/fade_in_animation.dart';
import 'not_found_flare.dart';

class NoBookFoundWidget extends StatelessWidget {
  const NoBookFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          width: 170,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NotFoundFlare(),
                const SizedBox(
                  height: 8,
                ),
                FadeInAnimation(
                  0.5,
                  const Text(
                    Strings.bookNotFound,
                    style: TextStyle(
                        fontFamily: "IranSans",
                        fontSize: 18,
                        color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
