import 'package:book_shop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(bgColor),
      body: SafeArea(
        child: Stack(
          children: [
            backgroundShapes(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(-1, 0),
                              blurRadius: 3,
                              color: Color(0xff000000).withOpacity(0.10)),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 23),
                        Text(
                          'ثبت نام',
                          style: TextStyle(fontFamily: "IranSans", fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 16),
                        registrationTextField(Icons.person, "نام کاربری..."),
                        SizedBox(height: 16),
                        registrationTextField(Icons.lock, "رمز عبور..."),
                        SizedBox(
                          height: 16,
                        ),
                        registrationButton(),
                        SizedBox(height: 8),
                        Text('ثبت نام کرده اید؟ ورود', style: TextStyle(
                          fontSize: 14,
                          fontFamily: "IranSans",
                          color: Color(0xff000000).withOpacity(0.55),
                        ),),
                        SizedBox(height: 16),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
