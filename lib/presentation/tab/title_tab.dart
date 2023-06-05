import '../animation/animation.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class TitleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 23),
          FadeInAnimation(0.25, MyToolBar(title: Strings.titleLabel)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: (MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2)),
                children: <Widget>[
                  FadeInAnimation(
                    0.5,
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
                  ),
                  FadeInAnimation(
                    0.5,
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
                  ),
                  FadeInAnimation(
                    0.75,
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
                  ),
                  FadeInAnimation(
                    0.75,
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
                  ),
                  FadeInAnimation(
                    1,
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
                  ),
                  FadeInAnimation(
                    1,
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
                              child: getTiles(
                                  Assets.foodImage, Strings.titleFood))),
                    ),
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
        const SizedBox(
          height: 5,
        ),
        Text(
          "$title",
          style: const TextStyle(
              fontFamily: "IranSans", fontSize: 16, color: Colors.black87),
        ),
      ],
    ));
  }
}
