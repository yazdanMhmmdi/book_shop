import 'dart:async';

import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/logic/bloc/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  HomeRepository _mostSalesRepository = new HomeRepository();
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield HomeLoading();
      try {
        final HomeModel homeModel =
            await _mostSalesRepository.fetchHome("sss");

        print(
            'MOstSalesSucces data : ' + homeModel.freshsBooks[0].id + " : XXX");

        yield HomeSuccess(homeModel);
      } catch (_) {
        yield HomeFailure();
      }
    }
  }
}
