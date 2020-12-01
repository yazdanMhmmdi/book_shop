import 'dart:async';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  String id; //TODO: add sharedPrefrences
  ButtonState buttonState = ButtonState.idle;

  @override
  void initState() {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      cubit: context.bloc<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthInitial) {
          // setState(() {
          //   _buttonState = ButtonState.loading;
          // });

        }
        if (state is AuthSuccess) {
          setState(() {
            buttonState = ButtonState.success;
          });
        } else if (state is AuthWrong) {
          setState(() {
            buttonState = ButtonState.fail;
          });
        } else if (state is AuthLoading) {
          setState(() {
            buttonState = ButtonState.loading;
          });
          print('ButtonLoading');
        }
      },
      child: Scaffold(
        backgroundColor: Color(bgColor),
        body: SafeArea(
          child: Stack(
            children: [
              backgroundShapes(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FadeInAnimation(
                    1,
                    Container(
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
                            MyTextFiled(
                                icon: Icons.person,
                                text: Strings.usernameLabel,
                                textFieldColor:
                                    Color(txfColor).withOpacity(0.15),
                                controller: _usernameController),
                            SizedBox(height: 16),
                            MyTextFiled(
                                icon: Icons.lock,
                                text: Strings.passwordLabel,
                                textFieldColor:
                                    Color(txfColor).withOpacity(0.15),
                                controller: _passwordController),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: MyButton(
                                    buttonState: buttonState,
                                    text: "تاییی",
                                    onTap: () {
                                      // setState(() {
                                      //   _buttonState = ButtonState.loading;
                                      // });
                                      context.bloc<AuthBloc>().add(LoginEvent(
                                          _usernameController.text,
                                          _passwordController.text));
                                    })),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.bloc<AuthBloc>().close();
    super.dispose();
  }
}
