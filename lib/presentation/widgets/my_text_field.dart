import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFiled extends StatelessWidget {
  var icon;
  var text;
  Color textFieldColor;
  TextEditingController controller;
  MyTextFiled(
      {@required this.controller,
      @required this.icon,
      @required this.text,
      @required this.textFieldColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: textFieldColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(icon, color: Color(icoColor)), onPressed: () {}),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "IranSans",
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '$text',
                    ),
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 16),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         border: InputBorder.none,
                //         hintText: 'نام کاربری'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
