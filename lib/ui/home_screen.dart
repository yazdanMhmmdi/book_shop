import 'package:book_shop/ui/home_tab.dart';
import 'package:book_shop/ui/horizontal_card.dart';
import 'package:book_shop/ui/title_tab.dart';
import 'package:book_shop/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MotionTabController _bottomNavController;

  String home = "خانه", titles = "موضوعات", account = "حساب کاربری";

  @override
  void initState() {
    _bottomNavController =
        new MotionTabController(initialIndex: 0, vsync: this);
    _bottomNavController.index = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: MotionTabBarView(
            controller: _bottomNavController,
            children: <Widget>[
              Container(
                child: Text('3'),
              ),
              TitleTab(),
              HomeTab(),
            ]),
      )),
      bottomNavigationBar: MotionTabBar(
        labels: [account, titles, home], //"خانه", "موضوعات", "حساب کاربری"
        initialSelectedTab: home,

        tabIconColor: Color(0xffA3A2A8),
        tabSelectedColor: Color(txfColor),
        onTabItemSelected: (int value) {
          print(value);
          setState(() {
            _bottomNavController.index = value;
          });
        },
        icons: [Icons.person, Icons.book, Icons.home],
        textStyle: TextStyle(
            color: Colors.black87,
            fontFamily: "IranSans",
            fontSize: 16,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  void dispose() {
    _bottomNavController.dispose();
    super.dispose();
  }
}
