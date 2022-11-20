import 'package:book_shop/core/network/remote_api_service.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/data/datasources/remote/book_shop_api_service.dart';
import 'package:book_shop/data/repository/title_posts_repository_impl.dart';
import 'package:book_shop/domain/repositories/home_repository.dart';
import 'package:book_shop/domain/repositories/titles_post_repository.dart';
import 'package:book_shop/domain/usecases/home_usecase.dart';
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
  //  usecases
  sl.registerLazySingleton(() => HomeUsecase(sl()));
  sl.registerLazySingleton(() => TitlePostsUsecase(sl()));

  //  repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<TitlesPostRepository>(
      () => TitlePostsRepositoryImpl(sl()));

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

  //! Domain
  //entities
  sl.registerSingleton(BookShopClient(sl()));
}
