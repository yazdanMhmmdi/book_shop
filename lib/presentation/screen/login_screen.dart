import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/cubit/form_validation_cubit.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/background_shapes.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_progress_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/warning_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late String id;
  ButtonState buttonState = ButtonState.idle;
  Color backgroundColor = IColors.green;
  late AuthBloc _authBloc;
  late FormValidationCubit _formValidationCubit;

  @override
  Widget build(BuildContext context) {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _authBloc = BlocProvider.of<AuthBloc>(context);
    _formValidationCubit = BlocProvider.of<FormValidationCubit>(context);

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
              Navigator.pushNamed(context, '/home');
            }
          },
        ),
        BlocListener<FormValidationCubit, FormValidationState>(
          listener: (context, state) {
            if (state is FormValidationStatus) {}
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
                                    Strings.loginLabel,
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
                                      textFieldColor:
                                          Color(txfColor).withOpacity(0.15),
                                      controller: _usernameController),
                                  BlocBuilder<FormValidationCubit,
                                      FormValidationState>(
                                    builder: (context, state) {
                                      if (state is FormValidationState) {
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
                                  const SizedBox(height: 16),
                                  MyTextFiled(
                                      icon: Icons.lock,
                                      text: Strings.passwordLabel,
                                      obscureText: true,
                                      textFieldColor:
                                          Color(txfColor).withOpacity(0.15),
                                      controller: _passwordController),
                                  BlocBuilder<FormValidationCubit,
                                      FormValidationState>(
                                    builder: (context, state) {
                                      if (state is FormValidationState) {
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
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: BlocBuilder<AuthBloc, AuthState>(
                                        builder: (context, state) {
                                          if (state is AuthInitial) {
                                            return buttonUI(ButtonState.idle);
                                          } else if (state is AuthLoading) {
                                            return buttonUI(
                                                ButtonState.loading);
                                          } else if (state is AuthSuccess) {
                                            return buttonUI(
                                                ButtonState.success);
                                          } else if (state is AuthFailure) {
                                            return buttonUI(ButtonState.fail);
                                          } else if (state is AuthWrong) {
                                            return buttonUI(ButtonState.fail);
                                          } else {
                                            return Container();
                                          }
                                        },
                                      )),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/sign_up', (e) => false);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          Strings.loginNSU,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "IranSans",
                                            color: IColors.boldGreen,
                                          ),
                                        ),
                                        Text(
                                          Strings.loginNeedSignUp,
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
                ),
              ),
            );
          } else if (state is InternetDisconnected) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: NoNetworkFlare(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buttonUI(ButtonState buttonState) {
    return MyButton(
        buttonState: buttonState,
        text: Strings.loginAccept,
        onTap: () {
          // setState(() {
          //   _buttonState = ButtonState.loading;
          // });
          _formValidationCubit.authValidatiors(
              _usernameController.text, _passwordController.text,
              doAfterValidation: () {
            _authBloc.add(
                LoginEvent(_usernameController.text, _passwordController.text));
          });
        });
  }
}
