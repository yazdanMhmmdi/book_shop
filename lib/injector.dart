import 'package:book_shop/core/network/remote_api_service.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/data/datasources/remote/book_shop_api_service.dart';
import 'package:book_shop/data/repository/title_posts_repository_impl.dart';
import 'package:book_shop/domain/repositories/account_repository.dart';
import 'package:book_shop/domain/repositories/auth_repository.dart';
import 'package:book_shop/domain/repositories/basket_repository.dart';
import 'package:book_shop/domain/repositories/home_repository.dart';
import 'package:book_shop/domain/repositories/titles_post_repository.dart';
import 'package:book_shop/domain/usecases/add_basket_usecase.dart';
import 'package:book_shop/domain/usecases/delete_basket_usecase.dart';
import 'package:book_shop/domain/usecases/edit_account_usecase.dart';
import 'package:book_shop/domain/usecases/get_account_usecase.dart';
import 'package:book_shop/domain/usecases/get_basket_usecase.dart';
import 'package:book_shop/domain/usecases/home_usecase.dart';
import 'package:book_shop/domain/usecases/login_usecase.dart';
import 'package:book_shop/domain/usecases/sign_up_usecase.dart';
import 'package:book_shop/domain/usecases/title_posts_usecase.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/entities/book_shop_client.dart';
import 'logic/bloc/home/home_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!  Features
  //  Blocs
  sl.registerFactory(() => HomeBloc(
        homeUsecase: sl(),
      ));
  sl.registerFactory(() => TitleBloc(
        titlePostsUsecase: sl(),
      ));
  sl.registerFactory(() => AuthBloc(
        formValidationCubit: sl(),
        loginUsecase: sl(),
        signUpUsecase: sl(),
      ));
  sl.registerFactory(() => BasketBloc(
        addBasketUsecase: sl(),
        getBasketUsecase: sl(),
        deleteBasketUsecase: sl(),
      ));
  sl.registerFactory(() => AccountBloc(
        formValidationCubit: sl(),
        getAccountUsecase: sl(),
        editAccountUsecase: sl(),
      ));
  //  usecases
  sl.registerLazySingleton(() => HomeUsecase(sl()));
  sl.registerLazySingleton(() => TitlePostsUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => GetBasketUsecase(sl()));
  sl.registerLazySingleton(() => AddBasketUsecase(sl()));
  sl.registerLazySingleton(() => DeleteBasketUsecase(sl()));
  sl.registerLazySingleton(() => GetAccountUsecase(sl()));
  sl.registerLazySingleton(() => EditAccountUsecase(sl()));

  //  repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<TitlesPostRepository>(
      () => TitlePostsRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<BasketRepository>(() => BasketRepositoryImpl(sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(sl()));

  //  remote datasources
  sl.registerLazySingleton<RemoteApiService>(() => RemoteApiServiceImpl(sl()));

  //  local datasources
  // sl.registerLazySingleton<NumberTriviaLocalDataSource>(
  //     () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  //!  Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // sl.registerLazySingleton(() => InputConverter());

  //!  Extentions
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  final FormValidationCubit _formValidationCubit = FormValidationCubit();
  sl.registerLazySingleton(() => _formValidationCubit);
  // sharedPrefs.clear();
  //! Domain
  //entities
  sl.registerSingleton(BookShopClient(sl()));
}
