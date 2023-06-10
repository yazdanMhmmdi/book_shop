// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import 'secondary_button_widget.dart';

class UpdateDialog extends StatefulWidget {
  Function? onTap;
  UpdateDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        counter++;
        if (counter == 2) exit(0);

        
        return false;
      },
      child: Dialog(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  Strings.updateUpdateToGetBetterExprience,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: IColors.balck35,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SecondaryButtonWidget(
                  buttonText: "دانلود",
                  onTap: () => widget.onTap!.call(),
                )
                // MyButton(
                //     buttonState: ButtonState.idle,
                //     text: "دانلود",
                //     onTap:)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
