import 'package:book_shop/constants/assets.dart';
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
                        height: 311,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(bgColor),
                          borderRadius: BorderRadius.circular(32),
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
