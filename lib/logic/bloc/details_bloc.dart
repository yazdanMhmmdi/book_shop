import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/details_model.dart';
import 'package:book_shop/data/repository/details_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
        yield DetailsFailure();
      }
    }
  }
}
