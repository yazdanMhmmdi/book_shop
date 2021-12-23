import 'dart:io';

import 'package:book_shop/presentation/router/app_router.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart' as window_size;
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  desktopMinScreenSize();
  runApp(MyApp());
}

void desktopMinScreenSize() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    window_size.DesktopWindow.setMinWindowSize(Size(420, 720));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = new AppRouter();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'فروشگاه کتاب',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGeneratedRoute,
        scrollBehavior: MyCustomScrollBehavior(),
      );
    });
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
