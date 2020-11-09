import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                          Strings.loginLabel,
                          style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 16),
                        textField(Icons.person, Strings.usernameLabel,
                            Color(txfColor).withOpacity(0.15), () {}),
                        SizedBox(height: 16),
                        textField(Icons.lock, Strings.passwordLabel,
                            Color(txfColor).withOpacity(0.15), () {}),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: button(Strings.loginAccept, () {}),
                        ),
                        SizedBox(height: 8),
                        Text(
                          Strings.loginNeedSignUp,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "IranSans",
                            color: Color(0xff000000).withOpacity(0.55),
                          ),
                        ),
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
