import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_text_field.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTab extends StatefulWidget {
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String username;

  @override
  void initState() {
    // context.bloc<AccountBloc>().add(GetDefaultEvent("1"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: BlocConsumer<AccountBloc, AccountState>(
            cubit: context.bloc<AccountBloc>(),
            listener: (context, state) {
              if (state is AccountInitial) {
              } else if (state is AccountLoading) {
              } else if (state is AccountSuccess) {
                _usernameController.text = state.accountModel.account.username;
                _passwordController.text = state.accountModel.account.password;
                setState(() {
                  username = state.accountModel.account.username;
                });
              } else if (state is AccountFailure) {
              } else {}
            },
            builder: (context, state) {
              print('build account tab');
              if (state is AccountSuccess) {
                _usernameController.text = state.accountModel.account.username;
                _passwordController.text = state.accountModel.account.password;
                username = state.accountModel.account.username;
              }
              return Column(
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  FadeInAnimation(
                              0.25, MyToolBar(title: Strings.accountLabel)),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: FadeInAnimation(
                              0.5, Container(
                        height: 358,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: FadeInAnimation(
                                0.75,
                                Container(
                                  height: 315,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(bgColor),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 16),
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
                                                    text: Strings.usernameLabel,
                                                    textFieldColor:
                                                        IColors.lowWhite,
                                                    controller:
                                                        _usernameController)),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                                height: 46,
                                                child: MyTextFiled(
                                                    icon: Icons.lock,
                                                    text: Strings.passwordLabel,
                                                    textFieldColor:
                                                        IColors.lowWhite,
                                                    controller:
                                                        _passwordController)),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: MyButton(
                                                  text: "${Strings.accountEdit}",
                                                  onTap: (state) => context
                                                      .bloc<AccountBloc>()
                                                      .add(EditEvent(
                                                          userId: "1",
                                                          newUsername:
                                                              _usernameController
                                                                  .text,
                                                          newPassword:
                                                              _passwordController
                                                                  .text))),
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
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
