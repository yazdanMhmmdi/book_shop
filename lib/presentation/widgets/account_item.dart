import 'package:flutter/material.dart';
import 'package:book_shop/constants/constants.dart';

class AccountItem extends StatelessWidget {
  Function() onTap;
  AccountItem({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: IColors.boldGreen,
                      size: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "لیست گفتگو ها",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Strings.fontIranSans,
                              fontWeight: FontWeight.w700,
                              color: IColors.balck85),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: IColors.boldGreen),
                          child: Icon(
                            Icons.chat,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 0,
                  color: Colors.black12,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
