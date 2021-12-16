import 'dart:async';

import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/shared_prefs_repository.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/account_item.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/warning_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  bool _usernameStatus = true, _passwordStatus = true;

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late String username = "";
  ButtonState? _buttonState = ButtonState.idle;

  @override
  void initState() {
    // context.bloc<AccountBloc>().add(GetDefaultEvent("1"));
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            child: BlocConsumer<AccountBloc, AccountState>(
              listener: (context, state) {
                _accountButtonStateListener(state);

                if (state is AccountInitial) {
                } else if (state is AccountLoading) {
                } else if (state is AccountSuccess) {
                  usernameController.text = state.accountModel.account.username;
                  passwordController.text = state.accountModel.account.password;
                  setState(() {
                    username = state.accountModel.account.username;
                  });
                } else if (state is AccountFailure) {}
              },
              builder: (context, state) {
                if (state is AccountSuccess) {
                  if (usernameController.text.isEmpty)
                    usernameController.text =
                        state.accountModel.account.username;
                  if (passwordController.text.isEmpty)
                    passwordController.text =
                        state.accountModel.account.password;
                  username = state.accountModel.account.username;
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 23,
                    ),
                    FadeInAnimation(
                        0.25, MyToolBar(title: Strings.settingsLabel)),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FadeInAnimation(
                        0.5,
                        Container(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 43),
                                child: FadeInAnimation(
                                  0.75,
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: IColors.green,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          child: Opacity(
                                            opacity: 0,
                                            child: Container(
                                              width: 28,
                                              height: 28,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white54,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${username}",
                                                style: TextStyle(
                                                    fontFamily: "IranSans",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                Strings.accountWelcome,
                                                style: TextStyle(
                                                    fontFamily: "IranSans",
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                  height: 46,
                                                  child: MyTextFiled(
                                                      icon: Icons.person,
                                                      text:
                                                          Strings.usernameLabel,
                                                      obscureText: false,
                                                      textFieldColor:
                                                          IColors.lowWhite,
                                                      controller:
                                                          usernameController)),
                                              // _usernameStatus
                                              //     ? Container()
                                              //     : WarningBar(
                                              //         text: Strings
                                              //             .signupUsernameWarning),
                                              widget._usernameStatus
                                                  ? Container()
                                                  : WarningBar(
                                                      text: Strings
                                                          .signupUsernameWarning),

                                              SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                  height: 46,
                                                  child: MyTextFiled(
                                                      icon: Icons.lock,
                                                      text:
                                                          Strings.passwordLabel,
                                                      obscureText: true,
                                                      textFieldColor:
                                                          IColors.lowWhite,
                                                      controller:
                                                          passwordController)),
                                              widget._passwordStatus
                                                  ? Container()
                                                  : WarningBar(
                                                      text: Strings
                                                          .signUpPasswordWarning),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: MyButton(
                                                    buttonState: _buttonState,
                                                    text:
                                                        "${Strings.accountEdit}",
                                                    onTap: () async {
                                                      SharedPreferences _prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      _prefs.clear();
                                                      authValidatiors();
                                                      if (widget
                                                              ._usernameStatus &&
                                                          widget
                                                              ._passwordStatus) {
                                                        BlocProvider.of<
                                                                    AccountBloc>(
                                                                context)
                                                            .add(EditEvent(
                                                                newUsername:
                                                                    usernameController
                                                                        .text,
                                                                newPassword:
                                                                    passwordController
                                                                        .text));
                                                      }
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 22,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 94,
                                  height: 94,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Image.asset(
                                    Assets.femaleAvatarImage,
                                    width: 94,
                                    height: 88,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // FadeInAnimation(0.75,
                    // AccountItem(onTap: () {
                    //   Navigator.pushNamed(context, '/chatList');
                    // }) //TODO: account items

                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _accountButtonStateListener(AccountState state) {
    if (state is AccountEditingLoading) {
      setState(() {
        _buttonState = ButtonState.loading;
      });
    } else if (state is AccountEditingSuccess) {
      setState(() {
        _buttonState = ButtonState.success;
        username = usernameController.text;
      });

      Timer(Duration(seconds: 2), () {
        setState(() {
          _buttonState = ButtonState.idle;
        });
      });
    } else if (state is AccountEditingFailure) {
      setState(() {
        _buttonState = ButtonState.fail;
      });
      Timer(Duration(seconds: 4), () {
        setState(() {
          _buttonState = ButtonState.idle;
        });
      });
    }
  }

  void authValidatiors() {
    if (usernameController.text.length < 17 &&
        usernameController.text.length >= 5) {
      setState(() {
        widget._usernameStatus = true;
      });
    } else {
      setState(() {
        widget._usernameStatus = false;
      });
    }

    if (passwordController.text.length >= 8 &&
        passwordController.text.length < 17) {
      setState(() {
        widget._passwordStatus = true;
      });
    } else {
      setState(() {
        widget._passwordStatus = false;
      });
    }
  }
}
