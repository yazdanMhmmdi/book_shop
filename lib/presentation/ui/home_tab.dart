import 'dart:math';
import 'dart:ui';

import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/server_failure_flare.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'horizontal_card.dart';

class HomeTab extends StatelessWidget {
  PageController _carouselController;
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
          List<FreshBooks> fbList = state.postModel.freshsBooks;
          return SingleChildScrollView(
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
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Container(
                                          height: 147,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 10),
                                                    spreadRadius: -2,
                                                    blurRadius: 20,
                                                    color: IColors.boldGreen
                                                        .withOpacity(0.75))
                                              ]),
                                        ),
                                      ),
                                      Container(
                                        height: 147,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: IColors.green),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Image.network(
                                                ImageAddressProvider.imageURL +
                                                    state.postModel
                                                        .poster[index].picture,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                  height: 175,
                                  viewportFraction: 0.8,
                                  autoPlayInterval: Duration(seconds: 6),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlay: true,
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
                        _animationDelay = _animationDelay + 0.3;
                        return FadeInAnimation(
                            _animationDelay,
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
                      _animationDelay2 = _animationDelay2 + 0.3;
                      return FadeInAnimation(
                        _animationDelay2,
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
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        } else if (state is HomeFailure) {
          return ServerFailureFlare();
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
