import '../../constants/colors.dart';
import 'package:flutter/material.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function? onTap;
  const SecondaryButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          onTap!.call();
        },
        child: Container(
          width: double.maxFinite,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: IColors.lowedBoldGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${buttonText}',
            style: TextStyle(
              color: IColors.boldGreen,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
