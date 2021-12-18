import 'package:flutter/material.dart';

abstract class GlobalWidget {
  static String _userId = "";
  static String get userId => _userId;

  static set userId(String value) {
    _userId = value;
  }

  static ValueNotifier<int> valueNotifier= ValueNotifier<int>(0);
}
