import 'package:flutter/material.dart';

class DetailSliderItem extends StatelessWidget {
  late String title, subTitle;
  DetailSliderItem({required this.title, required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontFamily: "iranSans",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          Text(
            '$subTitle',
            style: TextStyle(
                fontFamily: "iranSans", fontSize: 18, color: Colors.black38),
          )
        ],
      ),
    );
  }
}
