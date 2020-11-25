import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/data/model/home_model.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/home_state.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'horizontal_card.dart';

class HomeTab extends StatelessWidget {
  PageController _carouselController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return Container();
        } else if (state is HomeLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeSuccess) {
          List<MostSalesBooks> msList = state.postModel.mostSalesBooks;
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
                                          Image.network(
                                              ImageAddressProvider.imageURL +
                                                  state.postModel.poster[index]
                                                      .picture,
                                                      fit: BoxFit.fitWidth,),
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
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                autoPlay: true,
                                initialPage: 0,
                                enlargeCenterPage: true))
                      ],
                    ),
                  ),
                  titleText(Strings.homeMostSales),
                  SizedBox(height: 16),
                  Container(
                    height: 170,
                    child: ListView.builder(
                      padding: EdgeInsets.only(right: 8),
                      itemCount: state.postModel.freshsBooks.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return HorizontalCard(
                          id: msList[index].id,
                          name: msList[index].name,
                          thumbPicture: msList[index].pictureThumb,
                          writer: msList[index].writer,
                          voteCount: msList[index].voteCount,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  titleText(Strings.homeFresh),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeInitial) {
                        return Container();
                      } else if (state is HomeSuccess) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.postModel.freshsBooks.length,
                          itemBuilder: (context, index) {
                            return VerticalCard(
                                id: state.postModel.freshsBooks[index].id,
                                image: Assets.sampleImage_1,
                                name: state.postModel.freshsBooks[index].name,
                                thumbImage: state
                                    .postModel.freshsBooks[index].pictureThumb,
                                writer:
                                    state.postModel.freshsBooks[index].writer,
                                vote_count: state
                                    .postModel.freshsBooks[index].voteCount);
                          },
                        );
                      } else if (state is HomeLoading) {
                        return CircularProgressIndicator();
                      } else if (state is HomeFailure) {
                        return Text('HomeFailure');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is HomeFailure) {
          return Text('Failure');
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
