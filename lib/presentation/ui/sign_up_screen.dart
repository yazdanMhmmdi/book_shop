
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(bgColor), //TODO: Needs to be replace;
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
                          Strings.signupLabel,
                          style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 16),
                        textField(Icons.person, Strings.usernameLabel,
                            IColors.lowedBoldGreen, _usernameController),
                        SizedBox(height: 16),
                        textField(Icons.lock, Strings.passwordLabel,
                            IColors.lowedBoldGreen, _passwordController),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: button(Strings.signupAccept, () {
                            context.bloc<AuthBloc>().add(SignUpEvent(
                               username:  _usernameController.text,
                               password: _passwordController.text));
                          }),
                        ),
                        SizedBox(height: 8),
                        Text(
                          Strings.signupDidYouSignedUp,
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
