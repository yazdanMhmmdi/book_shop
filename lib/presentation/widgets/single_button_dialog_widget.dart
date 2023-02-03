import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class SingleButtonDialogWidget extends StatefulWidget {
  final String title;
  final String subTitle;

  final String buttonText;
  final String image;

  final Function? onPressed;

  const SingleButtonDialogWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.onPressed,
    required this.image,
  }) : super(key: key);

  @override
  _SingleButtonDialogWidgetState createState() =>
      _SingleButtonDialogWidgetState();
}

class _SingleButtonDialogWidgetState extends State<SingleButtonDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 56, right: 41, left: 25, bottom: 50),
            child: Container(
              width: 289,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(36)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 32.0, left: 32, right: 32, bottom: 16),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 41,
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: IColors.balck85,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      Text(
                        widget.subTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: IColors.balck35, fontSize: 14),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      button(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(widget.image)),
            ),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onPressed!.call(),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.maxFinite,
          height: 38,
          decoration: BoxDecoration(
            color: IColors.lowedBoldGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(color: IColors.boldGreen, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
