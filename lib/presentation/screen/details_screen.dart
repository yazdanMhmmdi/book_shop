import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/values.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/logic/cubit/detail_cubit.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_container.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_item.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_widget.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_progress_button.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

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
            return Scaffold(
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
                                        topRight: Radius.circular(double.parse(
                                            state.borderRadius.toString()))),
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
                                                                    : 0.0),
                                                            height: 108 +
                                                                (orientation ==
                                                                        Orientation
                                                                            .landscape
                                                                    ? 16.0
                                                                    : 0.0),
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
                                                        fontFamily: "iranSans",
                                                        fontSize: 20,
                                                        color: Colors.black38),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    name,
                                                    style: const TextStyle(
                                                        fontFamily: "iranSans",
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black87),
                                                    textAlign: TextAlign.center,
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
                                                          subTitle: coverType),
                                                      DetailSliderItem(
                                                          title: "صفحه",
                                                          subTitle: pagesCount),
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
                                                  fontSize: 20,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700),
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
                                                  if (state is BasketInitial) {
                                                    return myButton(
                                                        buttonState:
                                                            ButtonState.idle);
                                                  } else if (state
                                                      is BasketLoading) {
                                                    return myButton(
                                                        buttonState: ButtonState
                                                            .loading);
                                                  } else if (state
                                                      is BasketSuccess) {
                                                    return myButton(
                                                        buttonState: ButtonState
                                                            .success);
                                                  } else if (state
                                                      is BasketFailure) {
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
