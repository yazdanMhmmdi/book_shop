import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/data/repository/title_repository.dart';
import 'package:equatable/equatable.dart';

part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleBloc() : super(TitleInitial());
  TitleRepository _titleRepository = new TitleRepository();
  int siencePage = 1;
  int medicinePage = 1;
  int page = 1;
  TitleModel _model;
  bool sience = true;
  bool medicine = true;
  @override
  Stream<TitleState> mapEventToState(
    TitleEvent event,
  ) async* {
    if (event is FetchBooks) {
      yield TitleLoading();
      // try {
      //   _model = await _titleRepository.getTitle(
      //       page.toString(), event.title.toString());
      //   page++;

      try {
        if (page == 1) {
          _model = await _titleRepository.getTitle(
              page.toString(), event.title.toString());
          page++;
        }

        if (event.title == 1 && siencePage <= _model.data.totalPages) {
          if (sience) {
            sience = false;
            TitleModel _modelSience = await _titleRepository.getTitle(
                siencePage.toString(), event.title.toString());

            _modelSience.books.forEach((e) {
              _model.sience.add(e);
            });
            siencePage++;
          }
          yield TitleSuccess(_model.sience);
        } else if (event.title == 2 && medicinePage <= _model.data.totalPages) {
          if (medicine) {
            medicine = false;

            TitleModel _medicineModel = await _titleRepository.getTitle(
                medicinePage.toString(), event.title.toString());

            _medicineModel.books.forEach((e) {
              _model.medicine.add(e);
            });
            medicinePage++;
          }
          yield TitleSuccess(_model.medicine);
        } else {
          yield TitleNothingFound();
        }
      } catch (_) {
        print('why : ${_.toString()}');
        yield TitleFailure();
      }
    }
  }
}
