import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/data/repository/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  HomeRepository _mostSalesRepository = new HomeRepository();
  int page = 1;
  @override
  Stream<HomeState> mapEventToState( 
    HomeEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield HomeLoading();
      try {
        final HomeModel postModel =
            await _mostSalesRepository.fetchHome('sss');
        page++;
        print('MOstSalesSucces data : ' + postModel.freshsBooks[0].id + " : XXX");

        yield HomeSuccess(postModel);
      } catch (_) {
        yield HomeFailure();
      }
    }
  }
}
