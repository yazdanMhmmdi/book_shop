import 'package:book_shop/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _mostSalesRepository = HomeRepository();
  HomeBloc() : super(HomeInitial()) {
    on<FetchEvent>(_getHome);
  }

  Future<void> _getHome(FetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final HomeModel homeModel = await _mostSalesRepository.fetchHome("sss");
      emit(HomeSuccess(homeModel));
    } catch (_) {
      print(_);
      emit(HomeFailure());
    }
  }
}
