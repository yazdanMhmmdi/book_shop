import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/logic/bloc/home_event.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/ui/settings_tab.dart';
import 'package:book_shop/presentation/ui/basket_tab.dart';
import 'package:book_shop/presentation/ui/chat_list_screen.dart';
import 'package:book_shop/presentation/ui/home_tab.dart';
import 'package:book_shop/presentation/ui/title_tab.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/server_failure_flare.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart'; //optional

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _bottomNavController;
  bool failureInFirstTry = false;
  final _noNetworkFlare = new NoNetworkFlare();

  late HomeBloc _homeBloc;
  late AccountBloc _accountBloc;
  @override
  void initState() {
    _bottomNavController =
        new TabController(initialIndex: 3, vsync: this, length: 4);

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
                            NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
                        controller: _bottomNavController,
                        children: <Widget>[
                          BlocProvider.value(
                            value: _accountBloc,
                            child: SettingsTab(),
                          ),
                          // ChatListTab(),
                          BlocProvider(
                              create: (BuildContext context) => BasketBloc(),
                              child: BasketTab()),
                          TitleTab(),
                          BlocProvider.value(
                            value: _homeBloc,
                            child: HomeTab(),
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
                      labels: [
                        Strings.bottomNavSettings,
                        // Strings.bottomNavListofConversations,
                        Strings.bottomNavBasket,
                        Strings.bottomNavTitle,
                        Strings.bottomNavHome,
                      ],
                      initialSelectedTab: Strings.bottomNavHome,

                      tabIconColor: Color(0xffA3A2A8),
                      tabSelectedColor:
                          Color(txfColor), //TODO: needs to be replace
                      onTabItemSelected: (int value) {
                        setState(() {
                          _bottomNavController.index = value;
                        });
                      },
                      icons: [
                        Icons.settings,
                        // Icons.chat,
                        Icons.shopping_basket,
                        Icons.book,
                        Icons.home,
                      ],
                      textStyle: TextStyle(
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
