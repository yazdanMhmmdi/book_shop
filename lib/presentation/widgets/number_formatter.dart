import 'package:intl/intl.dart';

import '../../constants/constants.dart';

class NumberFormatter {
  static getNumber(int number) {
    return NumberFormat("#,##0.##").format(double.parse(number.toString())) +
        " ${Strings.currencyType}";
  }
}
