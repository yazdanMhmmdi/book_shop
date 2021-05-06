import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormatter {
  static getNumber(int number) {
    return NumberFormat("#,##0.##").format(double.parse(number.toString())) + " تومان";
  }
}
