import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';
import '../../constants/constants.dart';
import 'secondary_button_widget.dart';

class ServerFailureFlare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
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
            Strings.serverFailureTabTitle, //TODO: hardcoded text.
            style: TextStyle(
                fontFamily: "IranSans",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87),
          ),
          const Text(
            Strings.serverFailureTabDesc,
            style: TextStyle(
                fontFamily: "IranSans", fontSize: 16, color: Colors.black87),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: SecondaryButtonWidget(
              buttonText: Strings.serverFailureTabButtonText,
              onTap: () => Navigator.pushNamed(context, '/intro_screen'),
            ),
          )
        ],
      ),
    );
  }
}
