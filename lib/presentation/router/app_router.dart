import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/values.dart';
import '../../injector.dart';
import '../../logic/cubit/ckeck_update_cubit.dart';
import '../../logic/logic.dart';
import '../screen/screen.dart';

class AppRouter {
  late AuthBloc _authBloc;

  late AccountBloc _accountBloc;

  final InternetCubit _internetCubit = InternetCubit(
    connectionChecker: DataConnectionChecker(),
  );
  final _loginScreen = LoginScreen();

  final FormValidationCubit _formValidationCubit = FormValidationCubit();

  Route onGeneratedRoute(RouteSettings settings) {
    _authBloc = AuthBloc(
        loginUsecase: sl(),
        signUpUsecase: sl(),
        formValidationCubit: _formValidationCubit);
    _accountBloc = AccountBloc(
      formValidationCubit: _formValidationCubit,
      getAccountUsecase: sl(),
      editAccountUsecase: sl(),
    );
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
              BlocProvider(
                create: (context) => CheckUpdateCubit(
                  getUpdateUsecase: sl(),
                  packageInfoProvider: sl(),
                ),
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
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(
                create: (context) => BasketBloc(
                  addBasketUsecase: sl(),
                  getBasketUsecase: sl(),
                  deleteBasketUsecase: sl(),
                ),
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
                create: (context) => TitleBloc(
                  titlePostsUsecase: sl(),
                ),
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

      default:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _internetCubit,
                  ),
                  BlocProvider(
                    create: (context) => CheckUpdateCubit(
                      getUpdateUsecase: sl(),
                      packageInfoProvider: sl(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => CheckUpdateCubit(
                      getUpdateUsecase: sl(),
                      packageInfoProvider: sl(),
                    ),
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
