import 'dart:async';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/presentation/widgets/my_progress_button.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  late String text;
  Function onTap;
  ButtonState? buttonState = ButtonState.idle;
  MyButton({
    required this.text,
    required this.onTap,
    required this.buttonState,
  });

  double buttonRadius = 8.0;

  late double maxWidth;

  bool maxWidthFlag = true;

  ButtonState? mainButtonState = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return MyProgressButton(
      minWidth: 50.0,
      height: 46.0,
      maxWidth: 800,
      radius: buttonRadius,
      progressIndicatorAlignment: MainAxisAlignment.center,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      stateWidgets: {
        ButtonState.idle: Text(
          "${text}",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "IranSans",
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        ButtonState.loading: Container(),
        ButtonState.fail: Icon(
          Icons.close,
          color: Colors.white,
        ),
        ButtonState.success: Icon(
          Icons.check,
          color: Colors.white,
        )
      },
      stateColors: {
        ButtonState.idle: IColors.boldGreen,
        ButtonState.loading: IColors.boldGreen,
        ButtonState.fail: IColors.boldGreen,
        ButtonState.success: IColors.boldGreen,
      },
      onPressed: () {
        // setState(() {
        //   buttonState = widget.onTap(); //asdsadsdd
        // });
        onTap.call();

        // else if (widget.buttonState == ButtonState.idle) {
        //   setState(() {
        //     widget.buttonState = ButtonState.idle;
        //     buttonRadius = 8;
        //     maxWidth = MediaQuery.of(context).size.width;
        //   });
        // } else if (widget.buttonState == ButtonState.success) {
        //   setState(() {
        //     widget.buttonState = ButtonState.success;
        //     buttonRadius = 100;
        //     maxWidth = 50.0;
        //   });
        // }
      },
      state: buttonState!,
    );
  }
}
