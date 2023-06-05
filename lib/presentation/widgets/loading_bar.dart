import '../../constants/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class MyLoadingBar extends StatelessWidget {
  late String animation = "";
  MyLoadingBar({required this.animation});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 250,
        child: FlareActor(
          Assets.bookLoading,
          animation: animation,
        ),
      ),
    );
  }
}
