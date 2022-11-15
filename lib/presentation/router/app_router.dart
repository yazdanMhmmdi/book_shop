import 'package:book_shop/constants/values.dart';
import 'package:book_shop/networking/network_info.dart';
import 'package:book_shop/presentation/screen/screen.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/logic.dart';

import '../../injector.dart';

class AppRouter {
  late AuthBloc _authBloc;

  late AccountBloc _accountBloc;

  final InternetCubit _internetCubit = InternetCubit(
    connectionChecker: DataConnectionChecker(),
  );
  final _loginScreen = LoginScreen();

  final FormValidationCubit _formValidationCubit = FormValidationCubit();

  Route onGeneratedRoute(RouteSettings settings) {
    _authBloc = AuthBloc(formValidationCubit: _formValidationCubit);
    _accountBloc = AccountBloc(formValidationCubit: _formValidationCubit);
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
              BlocProvider.value(
                value: _formValidationCubit,
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
              BlocProvider.value(
                value: _formValidationCubit,
              )
            ],
            child: SignUpScreen(),
          ),
        );
      case '/home':
        return PageRouteBuilder(
            transitionDuration:
                const Duration(milliseconds: Values.animationDuration),
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
                    create: (_) => HomeBloc(homeUsecase: sl()),
                  ),
                  BlocProvider.value(
                    value: _accountBloc,
                  ),
                  BlocProvider.value(
                    value: _formValidationCubit,
                  ),
                ],
                child: HomeScreen(),
              );
            });
      case '/details':
        final Map<String, String> args =
            settings.arguments as Map<String, String>;

        return PageRouteBuilder(
          transitionDuration:
              const Duration(milliseconds: Values.animationDuration),
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
    _accountBloc.close();
    _internetCubit.close();
  }
}
