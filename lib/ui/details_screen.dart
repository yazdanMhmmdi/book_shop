import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.green,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 135),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 112),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'جیسون پیترسون',
                                    style: TextStyle(
                                        fontFamily: "iranSans",
                                        fontSize: 20,
                                        color: Colors.black38),
                                  ),
                                  Text(
                                    'قتل های انفجاری',
                                    style: TextStyle(
                                        fontFamily: "iranSans",
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(height: 10,),
                                  Divider(
                                    height: 20,
                                    color: IColors.grey,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('درباره کتاب'),
                                    SizedBox(height: 4,),
                                    Container(
                                      width: 58,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: IColors.boldGreen,
                                      ),
                                    )
                                  ],
                                ),
                                Text('اطلاعات ناشر'),

                              ],
                            ),
                            SizedBox(height: 16,),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: IColors.boldGreen.withOpacity(0.15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric( vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text('زبان'),
                                        Text('فارسی')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('زبان'),
                                        Text('فارسی')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('زبان'),
                                        Text('فارسی')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('زبان'),
                                        Text('فارسی')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                            Text('درباره کتاب'),
                            SizedBox(height: 8,),
                            Text('لورم لورم ایپسوم فارسی'),
                            SizedBox(height: 8,),
                            Container(
                              width: double.infinity,
                              height: 46,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: IColors.boldGreen,
                              ),
                              child: Center(child: Text('خرید')),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(38),
                          topRight: Radius.circular(38),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero)),
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 87,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[200],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 12),
                                blurRadius: 22,
                                color: Colors.black.withOpacity(0.25))
                          ]),
                    ),
                    Container(
                      width: 136,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

/*
Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(38),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        offset: Offset(1, -1),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('جیسون پترسون'),
                    ],
                  ),
                ),


*/
/*
Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 87,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[200],
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 12),
                                  blurRadius: 22,
                                  color: Colors.black.withOpacity(0.25))
                            ]),
                      ),
                      Container(
                        width: 136,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
*/
