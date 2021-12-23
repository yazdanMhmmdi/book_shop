import 'package:book_shop/constants/assets.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class ServerFailureFlare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlareLoading(
            width: 350,
            height: 350,
            startAnimation: 'Untitled',
            loopAnimation: 'Untitled',
            name: Assets.cosmos,
            onSuccess: (data) {},
            onError: (a, b) {}),
        const SizedBox(
          height: 4,
        ),
        const Text(
          'خطای سرور !',
          style: TextStyle(
              fontFamily: "IranSans",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
        const Text(
          'مشکلی هنگام ارتباط با سرور پیش آمده زود بر می گردیم',
          style: TextStyle(
              fontFamily: "IranSans", fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
