import 'dart:ui';

import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/home_slider_item.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/server_failure_flare.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'horizontal_card.dart';

class HomeTab extends StatelessWidget {
  late PageController _carouselController;
  double _animationDelay = 0.25;
  double _animationDelay2 = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return Container();
        } else if (state is HomeLoading) {
          return MyLoadingBar(animation: "Untitled");
        } else if (state is HomeSuccess) {
          List<MostSalesBooks> msList = state.postModel.mostSalesBooks;
          List<FreshsBooks> fbList = state.postModel.freshsBooks;
          return ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      child: Column(
                        children: [
                          FadeInAnimation(
                            0.25,
                            CarouselSlider.builder(
                                itemCount: state.postModel.poster.length,
                                itemBuilder: (context, index, realIndex) {
                                  return HomeSliderItem(
                                      picture: state
                                          .postModel.poster[index].picture);
                                },
                                options: CarouselOptions(
                                    height: 175,
                                    viewportFraction: 0.8,
                                    autoPlayInterval: Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlay: false,
                                    initialPage: 0,
                                    enlargeCenterPage: true)),
                          ),
                        ],
                      ),
                    ),
                    FadeInAnimation(0.5, titleText(Strings.homeMostSales)),
                    SizedBox(height: 16),
                    Container(
                      height: 180,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(right: 8),
                        itemCount: state.postModel.freshsBooks.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return FadeInAnimation(
                              _animationDelay + ((index + 1) * 0.3),
                              HorizontalCard(
                                id: msList[index].id,
                                name: msList[index].name,
                                thumbPicture: msList[index].pictureThumb,
                                writer: msList[index].writer,
                                voteCount: msList[index].voteCount,
                                description: msList[index].description,
                                language: msList[index].language,
                                coverType: msList[index].coverType,
                                pagesCount: msList[index].pagesCount,
                              ));
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    FadeInAnimation(1, titleText(Strings.homeFresh)),
                    SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.postModel.freshsBooks.length,
                      itemBuilder: (context, index) {
                        return FadeInAnimation(
                          _animationDelay2 + ((index + 1) * 0.3),
                          VerticalCard(
                            id: fbList[index].id,
                            image: fbList[index].pictureThumb,
                            name: fbList[index].name,
                            thumbImage: fbList[index].pictureThumb,
                            writer: fbList[index].writer,
                            voteCount: fbList[index].voteCount,
                            coverType: fbList[index].coverType,
                            description: fbList[index].description,
                            language: fbList[index].language,
                            pagesCount: fbList[index].pagesCount,
                            price: fbList[index].price.toString(),
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
        '$title',
        style: TextStyle(
            color: Colors.black87,
            fontFamily: "IranSans",
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
