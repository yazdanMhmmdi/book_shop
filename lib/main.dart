import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/bloc/details_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';

import 'package:book_shop/logic/bloc/home_event.dart';
import 'package:book_shop/logic/bloc/title_bloc.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/ui/details_screen.dart';
import 'package:book_shop/presentation/ui/home_screen.dart';
import 'package:book_shop/presentation/ui/login_screen.dart';
import 'package:book_shop/presentation/ui/sign_up_screen.dart';
import 'package:book_shop/presentation/ui/splash_screen.dart';
import 'package:book_shop/presentation/ui/title_details_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthBloc _authBloc = new AuthBloc();

  final HomeBloc _homeBloc = new HomeBloc();

  final AccountBloc _accountBloc = new AccountBloc();

  final InternetCubit _internetCubit =
      new InternetCubit(connectivity: Connectivity());
  final _loginScreen = LoginScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => BlocProvider.value(
              value: _internetCubit,
              child: SplashScreen(), //_authBloc
            ),
        '/login': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _authBloc,
                ),
                BlocProvider.value(
                  value: _internetCubit,
                ),
              ],
              child: _loginScreen,
            ),
        '/sign_up': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _authBloc,
                ),
                BlocProvider.value(
                  value: _internetCubit,
                ),
              ],
              child: SignUpScreen(),
            ),
        '/home': (context) => BlocProvider.value(
              value: _internetCubit,
              child: HomeScreen(
                homeBloc: _homeBloc..add(FetchEvent()),
                accountBloc: _accountBloc..add(GetDefaultEvent("1")),
              ),
            ),
        '/details': (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DetailsBloc(),
                ),
                BlocProvider.value(
                  value: _internetCubit,
                ),
              ],
              child: DetailsScreen(),
            ),
        '/title': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: _internetCubit,
                ),
                BlocProvider(
                  create: (context) => TitleBloc(),
                )
              ],
              child: TitleDetailsScreen(),
            ),
      },
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    _homeBloc.close();
    _accountBloc.close();
    super.dispose();
  }
}
