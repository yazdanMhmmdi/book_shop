import 'dart:async';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:book_shop/presentation/widgets/warning_bar.dart';
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
  ButtonState _buttonState = ButtonState.idle;
  bool _usernameStatus = true;
  bool _passwordStatus = true;
  Color backgroundColor = IColors.green;

  @override
  void initState() {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    authValidatiors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthInitial) {
        } else if (state is AuthLoading) {
          setState(() {
            _buttonState = ButtonState.loading;
          });
        } else if (state is AuthSuccess) {
          Timer(Duration(seconds: 2), () {
            setState(() {
              _buttonState = ButtonState.success;
            });
          });
          Timer(Duration(seconds: 4), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          });
        } else if (state is AuthFailure) {
          Timer(Duration(seconds: 2), () {
            setState(() {
              _buttonState = ButtonState.fail;
            });
          });
        } else if (state is AuthWrong) {
          setState(() {
            _buttonState = ButtonState.fail;
          });
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor, //TODO: Needs to be replace;
        body: SafeArea(
            child: BlocConsumer<InternetCubit, InternetState>(
          cubit: context.bloc<InternetCubit>(),
          listener: (context, state) {
            if (state is InternetConnected) {
              setState(() {
                backgroundColor = IColors.green;
              });
            } else {
              setState(() {
                backgroundColor = Colors.white;
              });
            }
          },
          builder: (context, state) {
            if (state is InternetConnected) {
              return Stack(
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
                                      color:
                                          Color(0xff000000).withOpacity(0.10)),
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
                                MyTextFiled(
                                    icon: Icons.person,
                                    text: Strings.usernameLabel,
                                    obscureText: false,
                                    textFieldColor: IColors.lowedBoldGreen,
                                    controller: _usernameController),
                                _usernameStatus
                                    ? Container()
                                    : WarningBar(
                                        text: Strings.signupUsernameWarning),
                                SizedBox(height: 16),
                                MyTextFiled(
                                    icon: Icons.lock,
                                    text: Strings.passwordLabel,
                                    obscureText: true,
                                    textFieldColor: IColors.lowedBoldGreen,
                                    controller: _passwordController),
                                _passwordStatus
                                    ? Container()
                                    : WarningBar(
                                        text: Strings.signUpPasswordWarning),
                                SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: MyButton(
                                      buttonState: _buttonState,
                                      text: Strings.signupAccept,
                                      onTap: () {
                                        if (_passwordStatus &&
                                            _usernameStatus) {
                                          print('OK LETS GO');
                                        }
                                        if (_usernameStatus &&
                                            _passwordStatus) {
                                          if (_usernameController.text.length !=
                                                  0 &&
                                              _passwordController.text.length !=
                                                  0) {
                                            context.bloc<AuthBloc>().add(
                                                SignUpEvent(
                                                    username:
                                                        _usernameController
                                                            .text,
                                                    password:
                                                        _passwordController
                                                            .text));
                                          }
                                        }
                                      }),
                                ),
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/login', (e) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ورود",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "IranSans",
                                          color: IColors.boldGreen,
                                        ),
                                      ),
                                      Text(
                                        Strings.signupDidYouSignedUp,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "IranSans",
                                          color: Color(0xff000000)
                                              .withOpacity(0.55),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return NoNetworkFlare();
            }
          },
        )),
      ),
    );
  }

  void authValidatiors() {
    _usernameController.addListener(() {
      if (_usernameController.text.length < 17 &&
          _usernameController.text.length >= 5) {
        print('ready to sign up');
        setState(() {
          _usernameStatus = true;
        });
      } else {
        print('no');
        setState(() {
          _usernameStatus = false;
        });
      }
    });

    _passwordController.addListener(() {
      if (_passwordController.text.length >= 8 &&
          _passwordController.text.length < 17) {
        setState(() {
          _passwordStatus = true;
        });
      } else {
        setState(() {
          _passwordStatus = false;
        });
      }
    });
  }
}
