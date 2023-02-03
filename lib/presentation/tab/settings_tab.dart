import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:book_shop/constants/constants.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab>
    with SingleTickerProviderStateMixin {
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  late FormValidationCubit _formValidationCubit;

  @override
  void initState() {
    _formValidationCubit = BlocProvider.of<FormValidationCubit>(context);
    BlocProvider.of<AccountBloc>(context).add(GetDefaultEvent());

    _formValidationCubit.usernameValidate(usernameController.text);

    usernameController.addListener(() {
      _formValidationCubit.usernameValidate(usernameController.text);
      print(
          "usernmame : ${usernameController.text}, ${passwordController.text}");
    });
    passwordController.addListener(() {
      _formValidationCubit.passwordValidate(passwordController.text);
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
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  FadeInAnimation(
                      0.25, MyToolBar(title: Strings.settingsLabel)),
                  const SizedBox(
                    height: 16,
                  ),
                  accountEditingSection(),
                  const SizedBox(height: 16),
                ],
              )))),
    );
  }

  Padding accountEditingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FadeInAnimation(
        0.5,
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 43),
              child: FadeInAnimation(
                0.75,
                AnimatedSize(
                  duration:
                      const Duration(milliseconds: Values.animationDuration),
                  curve: Curves.fastLinearToSlowEaseIn,
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: IColors.green,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Center(
                            child: Column(
                          children: [
                            BlocBuilder<AccountBloc, AccountState>(
                              builder: (context, state) {
                                if (state is AccountLoading) {
                                  return const Center(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 16, top: 8),
                                    child: CircularProgressIndicator(),
                                  ));
                                } else if (state is AccountSuccess) {
                                  return formFieldsUI(state: state);
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyButton(
                                        text: Strings.accountLoginOrSignUp,
                                        onTap: () => Navigator.pushNamed(
                                            context, '/login'),
                                        buttonState: ButtonState.idle),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 94,
                height: 94,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
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
    );
  }

  Widget formFieldsUI({var state}) {
    return BlocBuilder<FormValidationCubit, FormValidationState>(
      builder: (context, formValidationState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${state.username}",
              style: const TextStyle(
                  fontFamily: "IranSans",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const Text(
              Strings.accountWelcome,
              style: TextStyle(
                  fontFamily: "IranSans", fontSize: 16, color: Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
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
            formValidationState.isUsernameValid
                ? Container()
                : WarningBar(
                    text: formValidationState.errorMessage.isEmpty
                        ? Strings.signupUsernameWarning
                        : formValidationState.errorMessage),

            const SizedBox(
              height: 16,
            ),
            SizedBox(
                height: 46,
                child: MyTextFiled(
                    icon: Icons.lock,
                    text: Strings.passwordLabel,
                    obscureText: true,
                    textFieldColor: IColors.lowWhite,
                    controller: passwordController)),
            formValidationState.isPasswordValid
                ? Container()
                : WarningBar(text: Strings.signUpPasswordWarning),
            const SizedBox(
              height: 16,
            ),

            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountEditLoading) {
                  return buttonUI(buttonState: ButtonState.loading);
                } else if (state is AccountEditSuccess) {
                  return buttonUI(buttonState: ButtonState.success);
                } else if (state is AccountEditFailure) {
                  return buttonUI(buttonState: ButtonState.fail);
                } else if (state is AccountEditInitial) {
                  return buttonUI(buttonState: ButtonState.idle);
                } else if (state is AccountLoading) {
                  return Container();
                } else {
                  return buttonUI(buttonState: ButtonState.idle);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget buttonUI({ButtonState buttonState = ButtonState.idle}) {
    return BlocBuilder<FormValidationCubit, FormValidationState>(
        builder: (context, formValidationState) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MyButton(
            buttonState: buttonState,
            text: Strings.accountEdit,
            onTap: () async {
              if (formValidationState.isUsernameValid &&
                  formValidationState.isPasswordValid) {
                BlocProvider.of<AccountBloc>(context).add(EditEvent(
                    newUsername: usernameController.text,
                    newPassword: passwordController.text));
                _formValidationCubit.usernameValidate(usernameController.text);
                _formValidationCubit.passwordValidate(passwordController.text);
              }
            }),
      );
    });
  }
}
