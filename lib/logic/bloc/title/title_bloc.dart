import '../../../data/model/title_posts_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/params/titles_post_params.dart';
import '../../../data/model/book_model.dart';
import '../../../domain/usecases/title_posts_usecase.dart';
part 'title_event.dart';
part 'title_state.dart';

class TitleBloc extends Bloc<TitleEvent, TitleState> {
  TitleBloc({required this.titlePostsUsecase}) : super(TitleLoading()) {
    on<FetchBooks>(_getBooks);
  }
  TitlesPostRequestParams? titlesPostRequestParams = TitlesPostRequestParams();
  int page = 1;
  int totalPage = 1;
  int currentCategory = 1;
  final TitlePostsUsecase titlePostsUsecase;
  List<BookModel> _bookModelList = <BookModel>[];
  bool noMoreData = true;

  Future<void> _getBooks(FetchBooks event, Emitter<TitleState> emit) async {
    //change category and set values to default
    if (currentCategory != event.title) {
      page = 1;
      totalPage = 1;
      currentCategory = event.title!;
      _bookModelList.clear();
      noMoreData = true;
      emit(TitleLoading());
    }
    if (page != 1) noMoreData = page < totalPage;

    if (page <= totalPage) {
      titlesPostRequestParams!.categoryId = event.title;
      titlesPostRequestParams!.page = page;
      dynamic failureOrPosts =
          await titlePostsUsecase(titlesPostRequestParams!);
      page++;

      failureOrPosts.fold(
        (failure) {
          print("TitleFailure");
          emit(TitleFailure());
        },
        (TitlePostsModel posts) {
          print('TitleSuccess');

          if (posts.books.isEmpty) {
            noMoreData = false;
            emit(TitleLoading());
            emit(TitleNothingFound());
          }
          emit(TitleLoading());

          totalPage = posts.responseData.totalPages!;
          _bookModelList.addAll(posts.books);
        },
      );
    }
    if (page > totalPage) noMoreData = false;

    emit(TitleSuccess(model: _bookModelList, noMoreData: noMoreData));
  }
}
