// ignore_for_file: must_be_immutable

import 'package:book_shop/presentation/widgets/custom_progress_button.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../animation/animation.dart';
import 'widgets.dart';

class PayCheckWidget extends StatelessWidget {
  int tax, deliveryCost, fullCost;
  ButtonState buttonState;
  PayCheckWidget({
    required this.tax,
    required this.deliveryCost,
    required this.fullCost,
    required this.buttonState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInAnimation(
          0.25,
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                Strings.basketPaymentCheck,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Strings.fontIranSans,
                    color: IColors.balck85,
                    fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(height: 8),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.basketTax,
                          style: rightSideTextStyle(),
                        ),
                        Text(
                          NumberFormatter.getNumber(tax),
                          style: leftSideTextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.basketDeliveryCost,
                          style: rightSideTextStyle(),
                        ),
                        Text(
                          NumberFormatter.getNumber(deliveryCost),
                          style: leftSideTextStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.basketPay,
                          style: TextStyle(
                            fontSize: 14,
                            color: IColors.balck85,
                            fontFamily: Strings.fontIranSans,
                          ),
                        ),
                        Text(
                          NumberFormatter.getNumber(fullCost),
                          style: const TextStyle(
                              fontSize: 14,
                              color: IColors.boldGreen,
                              fontFamily: Strings.fontIranSans,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MyButton(
                        buttonState: buttonState,
                        text: Strings.basketPayit,
                        onTap: () async {}),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
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
