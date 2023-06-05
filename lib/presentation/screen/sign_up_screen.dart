import 'dart:async';

import '../animation/animation.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/logic.dart';
import '../../constants/constants.dart';

class SignUpScreen extends StatelessWidget {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  Color backgroundColor = IColors.green;
  late FormValidationCubit _formValidationCubit;
  late AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _formValidationCubit = BlocProvider.of<FormValidationCubit>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);

    _usernameController.addListener(() {
      _formValidationCubit.usernameValidate(_usernameController.text);
      print(
          "usernmame : ${_usernameController.text}, ${_passwordController.text}");
    });
    _passwordController.addListener(() {
      _formValidationCubit.passwordValidate(_passwordController.text);

      print(
          "password : ${_usernameController.text}, ${_passwordController.text}");
    });

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Timer(const Duration(seconds: 2), () {
                Navigator.pushNamed(context, '/home');
              });
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
                                        offset: const Offset(-1, 0),
                                        blurRadius: 3,
                                        color: const Color(0xff000000)
                                            .withOpacity(0.10)),
                                  ]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 23),
                                  const Text(
                                    Strings.signupLabel,
                                    style: TextStyle(
                                        fontFamily: "IranSans",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 16),
                                  MyTextFiled(
                                      icon: Icons.person,
                                      text: Strings.usernameLabel,
                                      obscureText: false,
                                      textFieldColor: IColors.lowedBoldGreen,
                                      controller: _usernameController),
                                  BlocBuilder<FormValidationCubit,
                                      FormValidationState>(
                                    builder: (context, state) {
                                      return state.isUsernameValid
                                          ? Container()
                                          : WarningBar(
                                              text: Strings
                                                  .signupUsernameWarning);
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  MyTextFiled(
                                      icon: Icons.lock,
                                      text: Strings.passwordLabel,
                                      obscureText: true,
                                      textFieldColor: IColors.lowedBoldGreen,
                                      controller: _passwordController),
                                  BlocBuilder<FormValidationCubit,
                                      FormValidationState>(
                                    builder: (context, state) {
                                      return state.isPasswordValid
                                          ? Container()
                                          : WarningBar(
                                              text: Strings
                                                  .signUpPasswordWarning);
                                    },
                                  ),
                                  const SizedBox(
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
                                          } else if (state is AuthWrong) {
                                            return buttonUI(ButtonState.fail);
                                          } else {
                                            return buttonUI(ButtonState.idle);
                                          }
                                        },
                                      )),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/login', (e) => false);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          Strings.signupNLO,
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
                                            color: const Color(0xff000000)
                                                .withOpacity(0.55),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
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
          _authBloc.add(SignUpEvent(
              username: _usernameController.text,
              password: _passwordController.text));
        });
  }
}
