import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data/data.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());

  DetailsRepository _detailsRepository = new DetailsRepository();
  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetDetails) {
      yield DetailsLoading();

      try {
        DetailsModel _detailsModel =
            await _detailsRepository.getDetails(event.post_id);
        yield DetailsSuccess(_detailsModel);
      } catch (_) {
        print('detailsBloc : ${_}');
        yield DetailsFailure();
      }
    }
  }
}
