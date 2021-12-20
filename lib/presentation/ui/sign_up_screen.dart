import 'dart:async';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/cubit/form_validation_cubit.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/logic/cubit/splash_cubit.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/background_shapes.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_progress_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:book_shop/presentation/widgets/warning_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  ButtonState _buttonState = ButtonState.idle;
  bool _usernameStatus = true;
  bool _passwordStatus = true;
  Color backgroundColor = IColors.green;
  late FormValidationCubit _formValidationCubit;
  late AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _usernameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _formValidationCubit = BlocProvider.of<FormValidationCubit>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);

    _usernameController.addListener(() {
      _formValidationCubit.authValidatiors(
          _usernameController.text, _passwordController.text,
          doAfterValidation: () {});
      print(
          "usernmame : ${_usernameController.text}, ${_passwordController.text}");
    });
    _passwordController.addListener(() {
      _formValidationCubit.authValidatiors(
          _usernameController.text, _passwordController.text,
          doAfterValidation: () {});
      print(
          "password : ${_usernameController.text}, ${_passwordController.text}");
    });

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Timer(Duration(seconds: 2), () {
                Navigator.pushNamed(context, '/home');
              });
            }
          },
        ),
        BlocListener<FormValidationCubit, FormValidationState>(
          listener: (context, state) {
            if (state is FormValidationStatus) {
              _usernameStatus = state.usernameStatus;
              _passwordStatus = state.passwordStatus;
            }
          },
        ),
      ],
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetConnected) {
            return Scaffold(
                backgroundColor: IColors.green,
                body: SafeArea(
                    child: Stack(
                  children: [
                    BackgroundShapes(),
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
                                        color: Color(0xff000000)
                                            .withOpacity(0.10)),
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
                                  BlocBuilder<FormValidationCubit,
                                      FormValidationState>(
                                    builder: (context, state) {
                                      if (state is FormValidationStatus) {
                                        return state.usernameStatus
                                            ? Container()
                                            : WarningBar(
                                                text: Strings
                                                    .signupUsernameWarning);
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  MyTextFiled(
                                      icon: Icons.lock,
                                      text: Strings.passwordLabel,
                                      obscureText: true,
                                      textFieldColor: IColors.lowedBoldGreen,
                                      controller: _passwordController),
                                  BlocBuilder<FormValidationCubit,
                                      FormValidationState>(
                                    builder: (context, state) {
                                      if (state is FormValidationStatus) {
                                        return state.passwordStatus
                                            ? Container()
                                            : WarningBar(
                                                text: Strings
                                                    .signUpPasswordWarning);
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                        builder: (context, state) {
                                          if (state is AuthLoading) {
                                            return buttonUI(
                                                ButtonState.loading);
                                          } else if (state is AuthSuccess) {
                                            return buttonUI(
                                                ButtonState.success);
                                          } else if (state is AuthFailure) {
                                            return buttonUI(ButtonState.fail);
                                          } else if (state is AuthInitial) {
                                            return buttonUI(ButtonState.idle);
                                          } else {
                                            return buttonUI(ButtonState.idle);
                                          }
                                        },
                                      )),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/login', (e) => false);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${Strings.signupNLO}",
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
                )));
          } else if (state is InternetDisconnected) {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: NoNetworkFlare()));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buttonUI(ButtonState _buttonState) {
    return MyButton(
        buttonState: _buttonState,
        text: Strings.signupAccept,
        onTap: () {
          _formValidationCubit.authValidatiors(
              _usernameController.text, _passwordController.text,
              doAfterValidation: () {
            _authBloc.add(SignUpEvent(
                username: _usernameController.text,
                password: _passwordController.text));
          });
        });
  }
}
