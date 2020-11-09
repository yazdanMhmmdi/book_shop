import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:book_shop/presentation/widgets/title_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TitleDetailsScreen extends StatefulWidget {
  @override
  _TitleDetailsScreenState createState() => _TitleDetailsScreenState();
}

class _TitleDetailsScreenState extends State<TitleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 735));

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: TitleSelector(
                  titles: [
                    Strings.titleScience,
                    Strings.titleMedicine,
                    Strings.titleLaw,
                    Strings.titleHistoric,
                    Strings.titleFood,
                    Strings.titleSport
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  VerticalCard(
                    image: Assets.sampleImage_1,
                  ),
                  VerticalCard(
                    image: Assets.sampleImage_2,
                  ),
                  VerticalCard(
                    image: Assets.sampleImage_1,
                  ),
                  VerticalCard(
                    image: Assets.sampleImage_2,
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
