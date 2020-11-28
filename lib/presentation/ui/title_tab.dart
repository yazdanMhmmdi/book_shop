import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TitleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 23),
          MyToolBar(title: Strings.titleLabel),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: (MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2)),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.black12,
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.pushNamed(context, '/title',
                                  arguments: <String, String>{
                                    'category': "2",
                                  });
                            },
                            child: getTiles(
                                Assets.drugImage, Strings.titleMedicine))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.black12,
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.pushNamed(context, '/title',
                                  arguments: <String, String>{
                                    'category': "1",
                                  });
                            },
                            child: getTiles(
                                Assets.labToolImage, Strings.titleScience))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.black12,
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.pushNamed(context, '/title',
                                  arguments: <String, String>{
                                    'category': "3",
                                  });
                            },
                            child: getTiles(
                                Assets.historyImage, Strings.titleHistoric))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.black12,
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.pushNamed(context, '/title',
                                  arguments: <String, String>{
                                    'category': "4",
                                  });
                            },
                            child:
                                getTiles(Assets.lawImage, Strings.titleLaw))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.black12,
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.pushNamed(context, '/title',
                                  arguments: <String, String>{
                                    'category': "6",
                                  });
                            },
                            child: getTiles(
                                Assets.sportImage, Strings.titleSport))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/title',
                                  arguments: <String, String>{
                                    'category': "5",
                                  });
                            },
                            splashColor: Colors.black12,
                            borderRadius: BorderRadius.circular(18),
                            child:
                                getTiles(Assets.foodImage, Strings.titleFood))),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget getTiles(image, title) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 45,
          height: 45,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "$title",
          style: TextStyle(
              fontFamily: "IranSans", fontSize: 16, color: Colors.black87),
        ),
      ],
    ));
  }
}
