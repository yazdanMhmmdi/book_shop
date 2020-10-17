import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            getToolBar(Strings.accountLabel),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 358,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "یزدان محمدی",
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
                                  SizedBox(height: 16,),
                                  Container(
                                      height: 46,
                                      child: textField(
                                          Icons.person,
                                          Strings.usernameLabel,
                                          IColors.lowWhite,
                                          () {})),
                                          SizedBox(height: 16,),
                                          Container(
                                      height: 46,
                                      child: textField(
                                          Icons.lock,
                                          Strings.passwordLabel,
                                          IColors.lowWhite,
                                          () {})),
                                          SizedBox(height: 16,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: button("ویرایش", () {}),
                                          ),
                                ],
                              ),
                            ),
                          ],
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
            )
          ],
        ),
      ),
    );
  }
}
