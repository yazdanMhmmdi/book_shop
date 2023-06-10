// ignore_for_file: must_be_immutable

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/remote_api_service.dart';
import 'core/network/update_app_api_service.dart';
import 'core/utils/package_info_provider.dart';
import 'data/data.dart';
import 'data/datasources/remote/book_shop_api_service.dart';
import 'data/datasources/remote/update_app_api_service_impl.dart';
import 'data/repository/title_posts_repository_impl.dart';
import 'data/repository/update_app_repository_impl.dart';
import 'domain/entities/book_shop_client.dart';
import 'domain/repositories/account_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/basket_repository.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/repositories/titles_post_repository.dart';
import 'domain/repositories/update_app_repository.dart';
import 'domain/usecases/add_basket_usecase.dart';
import 'domain/usecases/delete_basket_usecase.dart';
import 'domain/usecases/edit_account_usecase.dart';
import 'domain/usecases/get_account_usecase.dart';
import 'domain/usecases/get_basket_usecase.dart';
import 'domain/usecases/get_update_usecase.dart';
import 'domain/usecases/home_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';
import 'domain/usecases/title_posts_usecase.dart';
import 'logic/cubit/ckeck_update_cubit.dart';
import 'logic/logic.dart';

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

  sl.registerFactory(() => CheckUpdateCubit(
        getUpdateUsecase: sl(),
        packageInfoProvider: sl(),
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
  sl.registerLazySingleton(() => GetUpdateUsecase(sl()));

  //  repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<TitlesPostRepository>(
      () => TitlePostsRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<BasketRepository>(() => BasketRepositoryImpl(sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(sl()));
  sl.registerLazySingleton<UpdateAppRepository>(
      () => UpdateAppRepositoryImpl(sl()));
  //  remote datasources
  sl.registerLazySingleton<RemoteApiService>(() => RemoteApiServiceImpl(sl()));
  sl.registerLazySingleton<UpdateAppApiService>(
      () => UpdateAppApiServiceImpl(sl()));

  //  local datasources
  // sl.registerLazySingleton<NumberTriviaLocalDataSource>(
  //     () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));
  //!  Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => PackageInfoProvider(packageInfo: sl()));

  //!  Extentions
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  sl.registerLazySingleton(() => packageInfo);

  final FormValidationCubit _formValidationCubit = FormValidationCubit();
  sl.registerLazySingleton(() => _formValidationCubit);
  // sharedPrefs.clear();
  //! Domain
  //entities
  sl.registerSingleton(BookShopClient(sl()));
}
