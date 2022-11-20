import 'package:book_shop/data/model/book_model.dart';
import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:book_shop/constants/constants.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return Container();
        } else if (state is HomeLoading) {
          return MyLoadingBar(animation: "Untitled");
        } else if (state is HomeSuccess) {
          List<BookModel>? msList = state.postModel.mostSalesBooks;
          List<BookModel>? fbList = state.postModel.freshsBooks;
          return ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Column(
                      children: [
                        FadeInAnimation(
                          0.25,
                          CarouselSlider.builder(
                              itemCount: state.postModel.poster!.length,
                              itemBuilder: (context, index, realIndex) {
                                return HomeSliderItem(
                                    picture: state
                                        .postModel.poster![index].picture!);
                              },
                              options: CarouselOptions(
                                  height: 175,
                                  viewportFraction: 0.8,
                                  autoPlayInterval: const Duration(seconds: 6),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlay: false,
                                  initialPage: 0,
                                  enlargeCenterPage: true)),
                        ),
                      ],
                    ),
                    FadeInAnimation(0.5, titleText(Strings.homeMostSales)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(right: 8),
                        itemCount: state.postModel.freshsBooks!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return FadeInAnimation(
                              0.25 + ((index + 1) * 0.3),
                              HorizontalCard(
                                id: msList![index].id!,
                                name: msList[index].name!,
                                thumbPicture: msList[index].pictureThumb!,
                                writer: msList[index].writer!,
                                voteCount: msList[index].voteCount!,
                                description: msList[index].description!,
                                language: msList[index].language!,
                                coverType: msList[index].coverType!,
                                pagesCount: msList[index].pagesCount!,
                                blurhash: msList[index].blurhash!,
                              ));
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInAnimation(1, titleText(Strings.homeFresh)),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.postModel.freshsBooks!.length,
                      itemBuilder: (context, index) {
                        return FadeInAnimation(
                          1.0 + ((index + 1) * 0.3),
                          VerticalCard(
                            model: state.postModel.freshsBooks![0],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is HomeFailure) {
          return ServerFailureFlare();
        } else {
          return Container();
        }
      },
    );
  }

  Widget titleText(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87,
            fontFamily: "IranSans",
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
