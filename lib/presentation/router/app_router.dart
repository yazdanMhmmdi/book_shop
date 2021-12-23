import 'package:book_shop/constants/values.dart';
import 'package:book_shop/presentation/screen/screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/logic.dart';

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
