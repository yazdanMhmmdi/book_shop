import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.green,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 135),
          Expanded(
            child: Container(
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
