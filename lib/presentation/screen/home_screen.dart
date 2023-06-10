import '../tab/tab.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import '../../logic/logic.dart';
import '../../constants/constants.dart';

import '../../injector.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _bottomNavController;
  bool failureInFirstTry = false;
  late HomeBloc _homeBloc;
  late AccountBloc _accountBloc;
  @override
  void initState() {
    super.initState();
    _bottomNavController =
        TabController(initialIndex: 3, vsync: this, length: 4);

    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _accountBloc = BlocProvider.of<AccountBloc>(context);

    _homeBloc.add(FetchEvent());
    _accountBloc.add(GetDefaultEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<InternetCubit, InternetState>(
            builder: (context, state) {
              if (state is InternetConnected) {
                return Stack(
                  children: [
                    TabBarView(
                        physics:
                            const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
                        controller: _bottomNavController,
                        children: <Widget>[
                          BlocProvider.value(
                            value: _accountBloc,
                            child: SettingsTab(),
                          ),
                          // ChatListTab(),
                          BlocProvider(
                              create: (BuildContext context) => BasketBloc(
                                  deleteBasketUsecase: sl(),
                                  addBasketUsecase: sl(),
                                  getBasketUsecase: sl()),
                              child: BasketTab()),
                          TitleTab(),
                          // ValueListenableBuilder<int>(
                          // valueListenable: _counter,
                          // builder: (context, value, child) {
                          // return
                          BlocProvider.value(value: _homeBloc, child: HomeTab()
                              // );

                              // }
                              ),
                        ]),
                  ],
                );
              } else if (state is InternetDisconnected) {
                return NoNetworkFlare();
              } else if (state is InternetLoading) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is InternetConnected) {
              return BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeFailure) {
                    return ServerFailureFlare();
                  } else {
                    return MotionTabBar(
                      labels: const [
                        Strings.bottomNavSettings,
                        Strings.bottomNavBasket,
                        Strings.bottomNavTitle,
                        Strings.bottomNavHome,
                      ],
                      initialSelectedTab: Strings.bottomNavHome,

                      tabIconColor: const Color(0xffA3A2A8),
                      tabSelectedColor:
                          Color(txfColor), //TODO: needs to be replace
                      onTabItemSelected: (int value) {
                        setState(() {
                          _bottomNavController.index = value;
                        });
                      },
                      icons: const [
                        Icons.settings,
                        // Icons.chat,
                        Icons.shopping_basket,
                        Icons.book,
                        Icons.home,
                      ],
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontFamily: "IranSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    );
                  }
                },
              );
            } else if (state is InternetDisconnected) {
              return NoNetworkFlare();
            } else {
              return Container();
            }
          },
        ));
  }
}
