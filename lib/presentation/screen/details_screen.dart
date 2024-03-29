// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:book_shop/presentation/widgets/custom_progress_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../logic/logic.dart';
import '../../networking/networking.dart';
import '../widgets/single_button_dialog_widget.dart';
import '../widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  late Map<String, String> args;
  DetailsScreen({required this.args});
  late String voteCount;
  late String description;
  late String pagesCount;
  late String language;
  late String coverType;
  late String thumbPicture;
  late String name;
  late String writer;
  late String price;
  late String id;
  late Map<String, String> arguments;
  Color backgroundColor = IColors.green;
  late BasketBloc _basketBloc;
  late DetailCubit _animationCubit;

  @override
  Widget build(BuildContext context) {
    _basketBloc = BlocProvider.of<BasketBloc>(context);
    _animationCubit = BlocProvider.of<DetailCubit>(context);
    arguments = args;
    _animationCubit.initializeAnimations(context);

    // _detailsBloc.add(GetDetails(post_id: arguments["post_id"]));

    _getArguments();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetConnected) {
            return BlocListener<BasketBloc, BasketState>(
              listener: (context, state) {
                if (state is BasketDuplicatedFailure) {
                  Timer(Duration(milliseconds: 1600), () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogWidget(
                            title: Strings.detailsDuplicatedBookTitle,
                            subTitle: Strings.detailsDuplicatedBookSubTitle,
                            buttonText: Strings.detailsDuplicatedBookbuttonText,
                            image: Assets.warningImage,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  });
                } else if (state is BasketGuestUserFailure) {
                  Timer(Duration(milliseconds: 1600), () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogWidget(
                            title: Strings.detailsGuestUserTitle,
                            subTitle: Strings.detailsGuestUserSubTitle,
                            buttonText: Strings.detailsGuestUserButtonText,
                            image: Assets.manImage,
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign_up');
                            },
                          );
                        });
                  });
                } else if (state is BasketFailure) {
                  Timer(Duration(milliseconds: 1600), () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SingleButtonDialogWidget(
                            title: Strings.detailsAddToBasketServerErrorTitle,
                            subTitle:
                                Strings.detailsAddToBasketServerErrorSubTitle,
                            buttonText:
                                Strings.detailsAddToBasketServerErrorButtonText,
                            image: Assets.serverErrorImage,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  });
                }
              },
              child: Scaffold(
                backgroundColor: IColors.green,
                body: OrientationBuilder(builder: (context, orientation) {
                  return Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top + 16,
                                right: 24.0),
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                //close button
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: BlocBuilder<DetailCubit, DetailState>(
                          builder: (context, state) {
                            if (state is DetailStatus) {
                              return NotificationListener<
                                  DraggableScrollableNotification>(
                                onNotification: (notification) {
                                  _animationCubit.noto(notification);
                                  return false;
                                },
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.75,
                                  minChildSize: 0.75,
                                  builder: (context, scroll) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(double.parse(
                                              state.borderRadius.toString())),
                                          topRight: Radius.circular(
                                              double.parse(state.borderRadius
                                                  .toString()))),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(1, -1),
                                                blurRadius: 4,
                                                color: IColors.borderShadow,
                                              )
                                            ]),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: ListView(
                                            controller: scroll,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            children: [
                                              Center(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      color: Colors.transparent,
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            child: Container(
                                                              width: 108 +
                                                                  (orientation ==
                                                                          Orientation
                                                                              .landscape
                                                                      ? 16.0
                                                                      : 8.0),
                                                              height: 108 +
                                                                  (orientation ==
                                                                          Orientation
                                                                              .landscape
                                                                      ? 16.0
                                                                      : 8.0),
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      writer,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "iranSans",
                                                          fontSize: 18,
                                                          color:
                                                              Colors.black38),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      name,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "iranSans",
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Colors.black87),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                      thickness: 3,
                                                      color: IColors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DetailSliderWidget(
                                                  duration: const Duration(
                                                      milliseconds: Values
                                                          .animationDuration),
                                                  sliderContainers: [
                                                    DetailSliderContainer(
                                                      detailSliderItems: [
                                                        DetailSliderItem(
                                                            title: "سن",
                                                            subTitle: "21"),
                                                        DetailSliderItem(
                                                            title: "تعداد کتاب",
                                                            subTitle: "2 جلد"),
                                                        DetailSliderItem(
                                                            title: "دسته بندی",
                                                            subTitle: "3"),
                                                        DetailSliderItem(
                                                            title: "مجموع آرا",
                                                            subTitle: "0")
                                                      ],
                                                    ),
                                                    DetailSliderContainer(
                                                      detailSliderItems: [
                                                        DetailSliderItem(
                                                            title: "زبان",
                                                            subTitle: language),
                                                        DetailSliderItem(
                                                            title: "جلد",
                                                            subTitle:
                                                                coverType),
                                                        DetailSliderItem(
                                                            title: "صفحه",
                                                            subTitle:
                                                                pagesCount),
                                                        DetailSliderItem(
                                                            title: "رای",
                                                            subTitle: voteCount)
                                                      ],
                                                    ),
                                                  ]),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              const Text(
                                                Strings.detailsDescription,
                                                style: TextStyle(
                                                    fontFamily: "iranSans",
                                                    fontSize: 16,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                description,
                                                style: TextStyle(
                                                    fontFamily: "iranSans",
                                                    fontSize: 16,
                                                    height: 1.4,
                                                    color: IColors.balck35),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Center(
                                                child: BlocBuilder<BasketBloc,
                                                    BasketState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is BasketInitial) {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState.idle);
                                                    } else if (state
                                                        is BasketLoading) {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState
                                                                  .loading);
                                                    } else if (state
                                                        is BasketSuccess) {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState
                                                                  .success);
                                                    } else if (state
                                                        is BasketFailure) {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState.fail);
                                                    } else if (state
                                                        is BasketDuplicatedFailure) {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState.fail);
                                                    } else if (state
                                                        is BasketGuestUserFailure) {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState.fail);
                                                    } else {
                                                      return myButton(
                                                          buttonState:
                                                              ButtonState.idle);
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 35,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                      IgnorePointer(
                        child: BlocBuilder<DetailCubit, DetailState>(
                          builder: (context, state) {
                            if (state is DetailStatus) {
                              return Opacity(
                                opacity: state.percent,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ((orientation ==
                                                        Orientation.portrait
                                                    ? 10.h
                                                    : 5.h) *
                                                state.percent)),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 87,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.transparent,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset:
                                                            const Offset(0, 12),
                                                        blurRadius: 22,
                                                        color: Colors.black
                                                            .withOpacity(0.25))
                                                  ]),
                                            ),
                                            Hero(
                                              tag:
                                                  "post_${id}_${arguments["hero_type"]}",
                                              child: Container(
                                                width: 136,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      ImageAddressProvider
                                                              .imageURL +
                                                          thumbPicture,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
            );
          } else {
            return Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: NoNetworkFlare()));
          }
        },
      ),
    );
  }

  Widget myButton({ButtonState buttonState = ButtonState.idle}) {
    return MyButton(
        buttonState: buttonState,
        text: Strings.detailsBuy,
        onTap: () {
          _basketBloc.add(AddBasket(book_id: id));
        });
  }

  void _getArguments() {
    description = arguments['description'] ?? "";
    pagesCount = arguments['pagesCount'] ?? "";
    language = arguments['language'] ?? "";
    coverType = arguments['coverType'] ?? "";
    thumbPicture = arguments['thumbPicture'] ?? "";
    id = arguments["post_id"] ?? "";
    writer = arguments['writer'] ?? "";
    voteCount = arguments['voteCount'] ?? "";
    name = arguments['name'] ?? "";
    price = arguments['price'] ?? "";
  }
}
