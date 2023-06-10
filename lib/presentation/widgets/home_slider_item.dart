// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../networking/networking.dart';

class HomeSliderItem extends StatelessWidget {
  String picture;
  HomeSliderItem({required this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 147,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        spreadRadius: -2,
                        blurRadius: 20,
                        color: IColors.boldGreen.withOpacity(0.75))
                  ]),
            ),
          ),
          Container(
            height: 147,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: IColors.green),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 26, right: 16),
                  child: Column(
                    children: [
                      Text(Strings.homeYourFavBooks,
                          style: TextStyle(
                            fontFamily: Strings.fontIranSans,
                            color: IColors.white90,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(
                        height: 26,
                      ),
                      Container(
                        width: 114,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: IColors.greenTwo,
                        ),
                        child: Center(
                          child: Text(
                            Strings.homeDiscover,
                            style: TextStyle(
                              color: IColors.white90,
                              fontFamily: Strings.fontIranSans,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.network(
                  ImageAddressProvider.imageURL + picture,
                  fit: BoxFit.fill,
                  width: 120,
                  height: 150,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
