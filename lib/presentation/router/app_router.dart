import 'package:book_shop/constants/values.dart';
import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/logic/bloc/chat_bloc.dart';
import 'package:book_shop/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop/logic/bloc/details_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/title_bloc.dart';
import 'package:book_shop/logic/cubit/detail_cubit.dart';
import 'package:book_shop/logic/cubit/form_validation_cubit.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/logic/cubit/splash_cubit.dart';
import 'package:book_shop/presentation/screen/chat_list_screen.dart';
import 'package:book_shop/presentation/screen/chat_screen.dart';
import 'package:book_shop/presentation/screen/details_screen.dart';
import 'package:book_shop/presentation/screen/home_screen.dart';
import 'package:book_shop/presentation/screen/intro_screen.dart';
import 'package:book_shop/presentation/screen/login_screen.dart';
import 'package:book_shop/presentation/screen/sign_up_screen.dart';
import 'package:book_shop/presentation/screen/socket_test_screen.dart';
import 'package:book_shop/presentation/screen/splash_screen.dart';
import 'package:book_shop/presentation/screen/title_details_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final AuthBloc _authBloc = AuthBloc();

  final HomeBloc _homeBloc = HomeBloc();

  final AccountBloc _accountBloc = AccountBloc();

  final InternetCubit _internetCubit =
      InternetCubit(connectivity: Connectivity());
  final _loginScreen = LoginScreen();

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _internetCubit,
                //_authBloc
              ),
              BlocProvider(
                create: (context) => SplashCubit(),
              ),
            ],
            child: SplashScreen(),
          ),
        );
      case '/intro':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/login':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(
                create: (context) => FormValidationCubit(),
              )
            ],
            child: _loginScreen,
          ),
        );
      case '/sign_up':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(create: (context) => FormValidationCubit()),
            ],
            child: SignUpScreen(),
          ),
        );
      case '/home':
        return PageRouteBuilder(
            transitionDuration:
                Duration(milliseconds: Values.animationDuration),
            transitionsBuilder: (context, aniamtion, animationTime, child) {
              return FadeTransition(
                opacity: aniamtion,
                child: child,
              );
            },
            pageBuilder: (context, aniamtion, animationTime) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: _internetCubit,
                  ),
                  BlocProvider(
                    create: (_) => HomeBloc(),
                  ),
                  BlocProvider.value(
                    value: _accountBloc,
                  ),
                  BlocProvider(
                    create: (context) => FormValidationCubit(),
                  ),
                ],
                child: HomeScreen(),
              );
            });
      case '/details':
        final Map<String, String> args =
            settings.arguments as Map<String, String>;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: Values.animationDuration),
          transitionsBuilder: (context, ainmation, animationTime, child) {
            return FadeTransition(opacity: ainmation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DetailsBloc(),
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(
                create: (context) => BasketBloc(),
              ),
              BlocProvider(
                create: (context) => DetailCubit(),
              ),
            ],
            child: DetailsScreen(
              args: args,
            ),
          ),
        );
      case '/title':
        final Map<String, String> args =
            settings.arguments as Map<String, String>;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: Values.animationDuration),
          transitionsBuilder: (context, animation, animationTime, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(
                create: (context) => TitleBloc(),
              )
            ],
            child: TitleDetailsScreen(
              category: int.tryParse(args["category"].toString())!,
            ),
          ),
        );

      case '/socket':
        return MaterialPageRoute(
          builder: (_) => SocketTextScreen(),
        );
      case '/chat':
        final Map<String, String> args =
            settings.arguments as Map<String, String>;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: Values.animationDuration),
          transitionsBuilder: (context, ainmation, animationTime, child) {
            return FadeTransition(opacity: ainmation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => ChatBloc(),
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
            ],
            child: ChatScreen(
              args: args,
            ),
          ),
        );
      case '/chatList':
        return PageRouteBuilder(
          transitionDuration:
              const Duration(milliseconds: Values.animationDuration),
          transitionsBuilder: (context, ainmation, animationTime, child) {
            return FadeTransition(opacity: ainmation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (BuildContext context) => ChatlistBloc(),
            ),
            BlocProvider.value(
              value: _internetCubit,
            ),
          ], child: ChatListScreen()),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _internetCubit,
                  ),
                  BlocProvider(
                    create: (context) => SplashCubit(),
                  ),
                ], child: SplashScreen()));
    }
  }

  void dispose() {
    _authBloc.close();
    _homeBloc.close();
    _accountBloc.close();
    _internetCubit.close();
  }
}
