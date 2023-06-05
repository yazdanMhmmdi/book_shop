import 'dart:ui';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../logic/cubit/ckeck_update_cubit.dart';
import 'my_button.dart';
import 'my_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/strings.dart';

class UpdateDialog extends StatelessWidget {
  Function? onTap;
  UpdateDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 350,
          maxWidth: 350,
          minHeight: 400,
          maxHeight: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: SvgPicture.asset(
                Assets.updateApp,
                width: 100,
                height: 250,
              )),
              const Text(
                Strings.updateUpdateNow,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                Strings.updateUpdateToGetBetterExprience,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: IColors.balck35,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MyButton(
                  buttonState: ButtonState.idle,
                  text: "دانلود",
                  onTap: () => onTap!.call())
            ],
          ),
        ),
      ),
    );
  }
}
