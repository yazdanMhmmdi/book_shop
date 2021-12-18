import 'dart:async';

import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/shared_prefs_repository.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/cubit/form_validation_cubit.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/account_item.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_progress_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/server_failure_flare.dart';
import 'package:book_shop/presentation/widgets/warning_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late TextEditingController usernameController = TextEditingController();

  late TextEditingController passwordController = TextEditingController();

  late FormValidationCubit _formValidationCubit;

  @override
  void initState() {
    _formValidationCubit = BlocProvider.of<FormValidationCubit>(context);
    BlocProvider.of<AccountBloc>(context).add(GetDefaultEvent());
    _formValidationCubit.authValidatiors(
        usernameController.text, passwordController.text);
    usernameController.addListener(() {
      _formValidationCubit.authValidatiors(
          usernameController.text, passwordController.text);
      print(
          "usernmame : ${usernameController.text}, ${passwordController.text}");
    });
    passwordController.addListener(() {
      _formValidationCubit.authValidatiors(
          usernameController.text, passwordController.text);
      print(
          "password : ${usernameController.text}, ${passwordController.text}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountSuccess) {
          usernameController.text = state.username;
          passwordController.text = state.password;
        }
      },
      child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                  child: Column(
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
                                        children: [
                                          BlocBuilder<AccountBloc,
                                              AccountState>(
                                            builder: (context, state) {
                                              if (state is AccountLoading) {
                                                return Center(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16, top: 8),
                                                  child:
                                                      CircularProgressIndicator(),
                                                ));
                                              } else if (state
                                                  is AccountSuccess) {
                                                return formFieldsUI(
                                                    state: state);
                                              } else {
                                                return formFieldsUI(
                                                    state: state);
                                              }
                                            },
                                          ),
                                          BlocBuilder<AccountBloc,
                                              AccountState>(
                                            builder: (context, state) {
                                              if (state is AccountEditLoading) {
                                                return buttonUI(
                                                    buttonState:
                                                        ButtonState.loading);
                                              } else if (state
                                                  is AccountEditSuccess) {
                                                return buttonUI(
                                                    buttonState:
                                                        ButtonState.success);
                                              } else if (state
                                                  is AccountEditFailure) {
                                                return buttonUI(
                                                    buttonState:
                                                        ButtonState.fail);
                                              } else if (state
                                                  is AccountEditInitial) {
                                                return buttonUI(
                                                    buttonState:
                                                        ButtonState.idle);
                                              } else if (state
                                                  is AccountLoading) {
                                                return Container();
                                              } else
                                                return buttonUI(
                                                    buttonState:
                                                        ButtonState.idle);
                                            },
                                          ),
                                          SizedBox(
                                            height: 22,
                                          ),
                                        ],
                                      )),
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
                ],
              )))),
    );
  }

  Widget formFieldsUI({var state}) {
    return BlocBuilder<FormValidationCubit, FormValidationState>(
      builder: (context, formValidationState) {
        if (formValidationState is FormValidationStatus) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${state.username}",
                style: TextStyle(
                    fontFamily: "IranSans",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              Text(
                Strings.accountWelcome,
                style: TextStyle(
                    fontFamily: "IranSans", fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  height: 46,
                  child: MyTextFiled(
                      icon: Icons.person,
                      text: Strings.usernameLabel,
                      obscureText: false,
                      textFieldColor: IColors.lowWhite,
                      controller: usernameController)),
              // _usernameStatus
              //     ? Container()
              //     : WarningBar(
              //         text: Strings
              //             .signupUsernameWarning),
              formValidationState.usernameStatus
                  ? Container()
                  : WarningBar(text: Strings.signupUsernameWarning),

              SizedBox(
                height: 16,
              ),
              Container(
                  height: 46,
                  child: MyTextFiled(
                      icon: Icons.lock,
                      text: Strings.passwordLabel,
                      obscureText: true,
                      textFieldColor: IColors.lowWhite,
                      controller: passwordController)),
              formValidationState.passwordStatus
                  ? Container()
                  : WarningBar(text: Strings.signUpPasswordWarning),
              SizedBox(
                height: 16,
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }

  Widget buttonUI({ButtonState buttonState = ButtonState.idle}) {
    return BlocBuilder<FormValidationCubit, FormValidationState>(
      builder: (context, formValidationState) {
        if (formValidationState is FormValidationStatus) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyButton(
                buttonState: buttonState,
                text: "${Strings.accountEdit}",
                onTap: () async {
                  if (formValidationState.usernameStatus &&
                      formValidationState.passwordStatus) {
                    BlocProvider.of<AccountBloc>(context).add(EditEvent(
                        newUsername: usernameController.text,
                        newPassword: passwordController.text));
                    _formValidationCubit.authValidatiors(
                        usernameController.text, passwordController.text);
                  }
                }),
          );
        } else
          return Container();
      },
    );
  }
}
