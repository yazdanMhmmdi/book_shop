// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sizer/sizer.dart';

import 'injector.dart';
import 'presentation/router/app_router.dart';
import 'presentation/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(MyApp());
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
      return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            title: 'فروشگاه کتاب', //TODO: hardcoded text.
            theme: ThemeData(
                primarySwatch: Colors.green,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                fontFamily: "IranSans"),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: _appRouter.onGeneratedRoute,
            scrollBehavior: MyCustomScrollBehavior(),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
