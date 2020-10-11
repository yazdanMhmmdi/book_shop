import 'package:book_shop/ui/home_screen.dart';
import 'package:book_shop/ui/login_screen.dart';
import 'package:book_shop/ui/sign_up_screen.dart';
import 'package:book_shop/ui/splash_screen.dart';
import 'package:book_shop/ui/title_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TitleDetailsScreen(),
    );
  }
}
