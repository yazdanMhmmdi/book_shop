import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/presentation/ui/home_screen.dart';
import 'package:book_shop/presentation/ui/login_screen.dart';
import 'package:book_shop/presentation/ui/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthBloc _authBloc = new AuthBloc();
  final HomeBloc _homeBloc = new HomeBloc();
  final AccountBloc _accountBloc = new AccountBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login': (context) => BlocProvider.value(
              value: _authBloc,
              child: LoginScreen(),
            ),
        '/sign_up': (context) => BlocProvider.value(
              value: _authBloc,
              child: SignUpScreen(),
            ),
        '/': (context) => BlocProvider.value(
            value: _homeBloc,
            child: HomeScreen(
              homeBloc: _homeBloc..add(FetchEvent()),
              accountBloc: _accountBloc,
            )),
      },
    );
  }
}
