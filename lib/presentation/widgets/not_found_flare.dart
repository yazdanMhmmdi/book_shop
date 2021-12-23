import 'package:book_shop/constants/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class NotFoundFlare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 160,
      height: 135,
      child: FlareActor(
        Assets.bookEmpty,
        animation: 'Animations',
        fit: BoxFit.fill,
        alignment: Alignment.center,
      ),
    );
  }
}
