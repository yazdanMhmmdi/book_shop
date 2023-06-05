import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomerAgentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                offset: const Offset(7, 7),
                color: IColors.balck15),
          ]),
      child: Center(
        child: Image.asset(
          Assets.customerAgent,
          width: 35,
          height: 35,
        ),
      ),
    );
  }
}
