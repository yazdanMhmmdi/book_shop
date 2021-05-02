import 'package:book_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  Function onTap;
  BackButtonWidget({@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: IColors.boldGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.arrow_back,
            color: IColors.white90,
            size: 16,
          ),
        ),
      ),
    );
  }
}
