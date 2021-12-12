import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/data/repository/title_repository.dart';
import 'package:equatable/equatable.dart';

part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleBloc() : super(TitleInitial()) {
    TitleRepository _titleRepository = new TitleRepository();
    late int siencePage = 1;
    late int medicinePage = 1;
    late int historyPage = 1;
    late int foodPage = 1;
    late int lawPage = 1;
    late int sportPage = 1;
    late int page = 1;
    late TitleModel _model;

    late bool sience = true;
    late bool medicine = true;
    late bool history = true;
    late bool law = true;
    late bool food = true;
    late bool sport = true;
    //totalPages
    late int sienceTotalPage = 0;
    late int medicineTotalPage = 0;
    late int historyTotalPage = 0;
    late int lawTotalPage = 0;
    late int foodTotalPage = 0;
    late int sportTotalPage = 0;

    on<TitleEvent>((event, emit) async {
      if (event is FetchBooks) {
        emit(TitleLoading());
        print('TitleLOading');

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

          if (event.title == 1) {
            if (sience) {
              sience = false;
              TitleModel _modelSience = await _titleRepository.getTitle(
                  siencePage.toString(), event.title.toString());
              sienceTotalPage = _modelSience.data.totalPages;
              _modelSience.books.forEach((e) {
                _model.sience.add(e);
              });
              siencePage++;
            }
            if (_model.sience.length == 0) {
              emit(TitleNothingFound());
            } else {
              emit(TitleSuccess(_model.sience));
            }
            print('TitleSuccess sience');
          } else if (event.title == 2) {
            if (medicine) {
              medicine = false;
              TitleModel _medicineModel = await _titleRepository.getTitle(
                  medicinePage.toString(), event.title.toString());
              medicineTotalPage = _medicineModel.data.totalPages;

              _medicineModel.books.forEach((e) {
                _model.medicine.add(e);
              });
              medicinePage++;
            }

            if (_model.medicine.length == 0) {
              emit(TitleNothingFound());
            } else {
              emit(TitleSuccess(_model.medicine));
            }
            print('TitleSuccess medicine');
          } else if (event.title == 3) {
            if (history) {
              history = false;
              TitleModel _historyModel = await _titleRepository.getTitle(
                  historyPage.toString(), event.title.toString());
              historyTotalPage = _historyModel.data.totalPages;

              _historyModel.books.forEach((e) {
                _model.history.add(e);
              });
              historyPage++;
            }
            if (_model.history.length == 0) {
              emit(TitleNothingFound());
            } else {
              emit(TitleSuccess(_model.history));
            }

            print('TitleSuccess medicine');
          } else if (event.title == 4) {
            if (law) {
              law = false;
              TitleModel _lawModel = await _titleRepository.getTitle(
                  lawPage.toString(), event.title.toString());
              lawTotalPage = _lawModel.data.totalPages;

              _lawModel.books.forEach((e) {
                _model.law.add(e);
              });
              lawPage++;
            }
            if (_model.law.length == 0) {
              emit(TitleNothingFound());
            } else {
              emit(TitleSuccess(_model.law));
            }
            print('TitleSuccess medicine');
          } else if (event.title == 5) {
            if (food) {
              food = false;
              TitleModel _foodModel = await _titleRepository.getTitle(
                  foodPage.toString(), event.title.toString());
              foodTotalPage = _foodModel.data.totalPages;
              _foodModel.books.forEach((e) {
                _model.food.add(e);
              });
              foodPage++;
            }
            if (_model.food.length == 0) {
              emit(TitleNothingFound());
            } else {
              emit(TitleSuccess(_model.food));
            }
            print('TitleSuccess medicine');
          } else if (event.title == 6) {
            if (sport) {
              sport = false;
              TitleModel _sportModel = await _titleRepository.getTitle(
                  sportPage.toString(), event.title.toString());
              sportTotalPage = _sportModel.data.totalPages;

              _sportModel.books.forEach((e) {
                _model.sport.add(e);
              });
              sportPage++;
            }
            if (_model.sport.length == 0) {
              emit(TitleNothingFound());
            } else {
              emit(TitleSuccess(_model.sport));
            }
            print('TitleSuccess medicine');
          } else {
            emit(TitleNothingFound());
          }
        } catch (_) {
          print('why : ${_.toString()}');
          emit(TitleFailure());
          print('TitleFailure');
        }
      } else if (event is PaginationBooks) {
        if (event.title == 1 && siencePage <= sienceTotalPage) {
          emit(TitlePagination(_model.sience, 1));
          TitleModel _modelSience = await _titleRepository.getTitle(
              siencePage.toString(), event.title.toString());

          _modelSience.books.forEach((e) {
            _model.sience.add(e);
          });
          siencePage++;
          emit(TitleSuccess(_model.sience));
          print('TitleSuccess sience');
        } else if (event.title == 2 && medicinePage <= medicineTotalPage) {
          emit(TitlePagination(_model.medicine, 2));
          TitleModel _modelMedicine = await _titleRepository.getTitle(
              medicinePage.toString(), event.title.toString());

          _modelMedicine.books.forEach((e) {
            _model.medicine.add(e);
          });
          medicinePage++;
          emit(TitleSuccess(_model.medicine));
          print('TitleSuccess sience');
        } else if (event.title == 3 && historyPage <= historyTotalPage) {
          emit(TitlePagination(_model.history, 3));
          TitleModel _modelHistory = await _titleRepository.getTitle(
              historyPage.toString(), event.title.toString());

          _modelHistory.books.forEach((e) {
            _model.history.add(e);
          });
          historyPage++;
          emit(TitleSuccess(_model.history));
          print('TitleSuccess sience');
        } else if (event.title == 4 && lawPage <= lawTotalPage) {
          emit(TitlePagination(_model.law, 4));
          TitleModel _modelLaw = await _titleRepository.getTitle(
              lawPage.toString(), event.title.toString());

          _modelLaw.books.forEach((e) {
            _model.law.add(e);
          });
          lawPage++;
          emit(TitleSuccess(_model.law));
          print('TitleSuccess sience');
        } else if (event.title == 5 && foodPage <= foodTotalPage) {
          emit(TitlePagination(_model.food, 5));
          TitleModel _modelFood = await _titleRepository.getTitle(
              foodPage.toString(), event.title.toString());

          _modelFood.books.forEach((e) {
            _model.food.add(e);
          });
          foodPage++;
          emit(TitleSuccess(_model.food));
          print('TitleSuccess sience');
        } else if (event.title == 6 && sportPage <= sportTotalPage) {
          emit(TitlePagination(_model.sport, 6));
          TitleModel _modelSport = await _titleRepository.getTitle(
              sportPage.toString(), event.title.toString());

          _modelSport.books.forEach((e) {
            _model.sport.add(e);
          });
          sportPage++;
          emit(TitleSuccess(_model.sport));
          print('TitleSuccess sience');
        }
      }
    });
  }
}
