import '../../constants/constants.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class NoNetworkFlare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FlareLoading(
              width: 306,
              height: 265,
              name: Assets.noNetworkAvailable,
              startAnimation: 'no_netwrok',
              loopAnimation: 'no_netwrok',
              onSuccess: (data) {},
              onError: (a, b) {}),
        ),
        const Text(
          '! اتصال به شبکه قطع شد', //TODO: hardcoded text.
          style: TextStyle(
              fontFamily: "IranSans",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
        const Text(
          'لطفا اتصال به اینترنت خود را بررسی کنید',
          style: TextStyle(
              fontFamily: "IranSans", fontSize: 18, color: Colors.black87),
        ),
      ],
    );
  }
}
