import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_event.dart';
import 'package:book_shop/presentation/ui/account_tab.dart';
import 'package:book_shop/presentation/ui/home_tab.dart';
import 'package:book_shop/presentation/ui/title_tab.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class HomeScreen extends StatefulWidget {
  HomeBloc homeBloc;
  AccountBloc accountBloc;
  @override
  _HomeScreenState createState() => _HomeScreenState();
  HomeScreen({@required this.homeBloc, @required this.accountBloc});
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MotionTabController _bottomNavController;
  @override
  void initState() {
    _bottomNavController =
        new MotionTabController(initialIndex: 0, vsync: this);
    _bottomNavController.index = 2;
    // widget.accountBloc.add(GetDefaultEvent("1"));
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
              BlocProvider.value(
                value: widget.accountBloc,
                child: AccountTab(),
              ),
              TitleTab(),
              BlocProvider.value(
                value: widget.homeBloc,
                child: HomeTab(),
              ),
            ]),
      )),
      bottomNavigationBar: MotionTabBar(
        labels: [
          Strings.bottomNavAccount,
          Strings.bottomNavTitle,
          Strings.bottomNavHome
        ], //"خانه", "موضوعات", "حساب کاربری"
        initialSelectedTab: Strings.bottomNavHome,
        
        tabIconColor: Color(0xffA3A2A8),
        tabSelectedColor: Color(txfColor), //TODO: needs to be replace
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
