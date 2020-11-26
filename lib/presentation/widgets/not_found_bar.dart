import 'package:book_shop/constants/assets.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class NotFoundBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: FlareLoading(
        width: 120,
        height: 120,
        name: Assets.bookDropping,
        startAnimation: 'books_in',
        onError: (error, stacktrace) {},
        onSuccess: (data) {},
      ),
    );
  }
}
