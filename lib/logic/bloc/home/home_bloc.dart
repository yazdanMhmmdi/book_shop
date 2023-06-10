import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failure.dart';
import '../../../core/params/home_params.dart';
import '../../../core/utils/constants.dart';
import '../../../data/data.dart';
import '../../../domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;

  HomeBloc({required this.homeUsecase}) : super(HomeInitial()) {
    on<FetchEvent>(_getHome);
  }

  Future<void> _getHome(FetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final failureOrPosts = await homeUsecase(HomeParams());
    emit(await failureOrPosts.fold(
      (failure) => HomeFailure(),
      (posts) {
        return HomeSuccess(posts);
      },
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kServerFailureMessage;

      default:
        return 'Unexpected errror';
    }
  }
}
