import 'dart:async';

import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/logic/bloc/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository _mostSalesRepository = new HomeRepository();
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is FetchEvent) {
        emit(HomeLoading());
        try {
          final HomeModel homeModel =
              await _mostSalesRepository.fetchHome("sss");
          emit(HomeSuccess(homeModel));
        } catch (_) {
          print(_);
          emit(HomeFailure());
        }
      }
    });
  }
}
