import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFiled extends StatefulWidget {
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
  _MyTextFiledState createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
    final _formKey = GlobalKey<FormState>();

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
            color: widget.textFieldColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(widget.icon, color: Color(icoColor)),
                    onPressed: () {}),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "yes";
                      }
                      return "no";
                    },
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "IranSans",
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '${widget.text}',
                    ),
                    inputFormatters: [
                      new FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z0-9]+$')),
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
