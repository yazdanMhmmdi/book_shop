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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 142,
              decoration: BoxDecoration(
                  color: Color(txfColor).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: Container(
                      width: 81,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: Offset(7, 7),
                              blurRadius: 10)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'کتاب دوراهی',
                          style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "جودی پیکلت",
                          style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 14,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
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
