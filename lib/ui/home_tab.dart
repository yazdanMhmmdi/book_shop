import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/ui/vertical_card.dart';
import 'package:book_shop/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'horizontal_card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 147,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(bgColor),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          titleText('پرفروش ترین ها'),
          SizedBox(height: 16),
          Container(
            height: 160,
            child: ListView.builder(
              padding: EdgeInsets.only(right: 8),
              itemCount: 41,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return HorizontalCard();
              },
            ),
          ),
          SizedBox(height: 16),
          titleText('تازه ها'),
          SizedBox(
            height: 16,
          ),
          VerticalCard(
            image: Assets.sampleImage_1,
          ),
        ],
      ),
    );
  }

  Widget titleText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '$title',
        style: TextStyle(
            color: Colors.black87,
            fontFamily: "IranSans",
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
