import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:flutter/material.dart';

class BasketTab extends StatefulWidget {
  @override
  _BasketTabState createState() => _BasketTabState();
}

class _BasketTabState extends State<BasketTab> {
  ButtonState _buttonState = ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 23,
              ),
              FadeInAnimation(0.25, MyToolBar(title: Strings.basketLabel)),
              SizedBox(
                height: 16,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
              SizedBox(
                height: 22,
              ),
              Column(
                children: [
                  FadeInAnimation(
                    0.5,
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "صورتحساب",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: Strings.fontIranSans,
                              color: IColors.balck85,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                  SizedBox(height: 8),
                  FadeInAnimation(
                    0.75,
                    Container(
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        color: IColors.lowedBoldGreen,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Strings.basketTax,
                                    style: rightSideTextStyle(),
                                  ),
                                  Text(
                                    "24000 تومان",
                                    style: leftSideTextStyle(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Strings.basketDeliveryCost,
                                    style: rightSideTextStyle(),
                                  ),
                                  Text(
                                    "24000 تومان",
                                    style: leftSideTextStyle(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Strings.basketPay,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: IColors.balck85,
                                      fontFamily: Strings.fontIranSans,
                                    ),
                                  ),
                                  Text(
                                    "24000 تومان",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: IColors.boldGreen,
                                        fontFamily: Strings.fontIranSans,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              MyButton(
                                  buttonState: _buttonState,
                                  text: Strings.basketPayit,
                                  onTap: () {
                                    print('sss');
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle rightSideTextStyle() {
    return TextStyle(
        fontSize: 16, fontFamily: Strings.fontIranSans, color: IColors.balck35);
  }

  TextStyle leftSideTextStyle() {
    return TextStyle(
        fontSize: 16,
        fontFamily: Strings.fontIranSans,
        color: IColors.balck35,
        fontWeight: FontWeight.w700);
  }
}
