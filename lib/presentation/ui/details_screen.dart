import 'dart:async';
import 'dart:math';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/numbers.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/logic/bloc/details_bloc.dart';
import 'package:book_shop/logic/cubit/detail_screen_animation_cubit.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/animation/fade_in_transition.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_container.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_item.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_widget.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sizer/sizer.dart';

class DetailsScreen extends StatefulWidget {
  late Map<String, String> args;
  DetailsScreen({required this.args});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late DetailsBloc _detailsBloc;
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
  ButtonState _buttonState = ButtonState.idle;
  Color backgroundColor = IColors.green;
  bool _pullUpAnimationFlag = true;
  bool _fadeAnimationFlag = true;
  late AnimationController _pullUpController;
  AccountRepository _accountRepository = AccountRepository();
  late String user_id;
  Random _random = new Random();
  late int _randAge, _randBookCount, _randCategory, _randVote;
  late double _screenHeight;
  late BasketBloc _basketBloc;
  late DetailScreenAnimationCubit _animationCubit;

  int _animationDuration = 300;

  ///

  @override
  void initState() {
    _pullUpController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _basketBloc = BlocProvider.of<BasketBloc>(context);
    _animationCubit = BlocProvider.of<DetailScreenAnimationCubit>(context);

    getUserId();
    _pullUpController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = widget.args;
    _screenHeight = MediaQuery.of(context).size.height;
    _animationCubit.initializeAnimations(context);

    // _detailsBloc.add(GetDetails(post_id: arguments["post_id"]));

    _getArguments();

    return WillPopScope(
      onWillPop: () async {
        _pullDownAnimation();
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
          if (state is InternetConnected) {
            setState(() {
              backgroundColor = IColors.green;
            });
          } else {
            setState(() {
              backgroundColor = Colors.white;
            });
          }
        }, builder: (context, state) {
          if (state is InternetConnected) {
            return BlocListener<BasketBloc, BasketState>(
              listener: (context, state) {
                if (state is BasketSuccess) {
                  buttonStateSuccess();
                } else if (state is BasketFailure) {
                  buttonSatteFailure();
                } else {}
              },
              child: OrientationBuilder(builder: (context, orientation) {
                return Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Padding( TODO: chat item
                        //   padding: const EdgeInsets.only(top: 16, left: 24),
                        //   child: IconButton(
                        //     iconSize: 30,
                        //     icon: Icon(
                        //       Icons.chat,
                        //       color: Colors.white,
                        //     ),
                        //     onPressed: () => Navigator.pushNamed(
                        //         context, '/chat',
                        //         arguments: <String, String>{
                        //           'post_id': "${id}",
                        //           'name': "${name}",
                        //           'writer': "${writer}",
                        //           'voteCount': "${voteCount}",
                        //           'thumbPicture': "${thumbPicture}",
                        //           'hero_type': "v",
                        //           'price': '${price}',
                        //           'user_id': "${user_id}",
                        //         }),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 16,
                              right: 24.0),
                          child: Container(
                            child: IconButton(
                              iconSize: 30,
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _pullDownAnimation();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: BlocBuilder<DetailScreenAnimationCubit,
                          DetailScreenAnimationState>(
                        builder: (context, state) {
                          if (state is DetailScreenAnimationStatus) {
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
                                  return Container(
                                    child: ClipRRect(
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
                                                offset: Offset(1, -1),
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
                                                      "${writer}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "iranSans",
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black38),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "iranSans",
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Colors.black87),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Divider(
                                                      height: 20,
                                                      thickness: 3,
                                                      color: IColors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              DetailSliderWidget(
                                                  duration: Duration(
                                                      milliseconds: Numbers
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
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Text(
                                                Strings.detailsDescription,
                                                style: TextStyle(
                                                    fontFamily: "iranSans",
                                                    fontSize: 20,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                ' ',
                                                style: TextStyle(
                                                    fontFamily: "iranSans",
                                                    fontSize: 16,
                                                    height: 1.4,
                                                    color: IColors.balck35),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Center(
                                                child: MyButton(
                                                    buttonState: _buttonState,
                                                    text: Strings.detailsBuy,
                                                    onTap: () {
                                                      _basketBloc.add(AddBasket(
                                                          book_id: id));
                                                      setState(() {
                                                        _buttonState =
                                                            ButtonState.loading;
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 35,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),
                    ),
                    IgnorePointer(
                      child: BlocBuilder<DetailScreenAnimationCubit,
                          DetailScreenAnimationState>(
                        builder: (context, state) {
                          if (state is DetailScreenAnimationStatus) {
                            return Opacity(
                              opacity: state.percent,
                              child: Container(
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
                                                      offset: Offset(0, 12),
                                                      blurRadius: 22,
                                                      color: Colors.black
                                                          .withOpacity(0.25))
                                                ]),
                                          ),
                                          Hero(
                                            tag:
                                                "post_${id}_${arguments["hero_type"]}", //TODO: check hero types
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
                          } else
                            return Container();
                        },
                      ),
                    ),
                  ],
                );
              }),
            );
          } else {
            return NoNetworkFlare();
          }
        }),
      ),
    );
  }

  Widget myButton(Function() onTap) {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: IColors.boldGreen,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Center(
              child: Text(
            'خرید',
            style: TextStyle(
                fontFamily: "iranSans",
                fontSize: 18,
                color: Colors.white70,
                fontWeight: FontWeight.w700),
          )),
        ),
      ),
    );
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

  void _pullDownAnimation() {
    Navigator.pop(context);

    _pullUpController.repeat(reverse: true);
    Timer(Duration(milliseconds: _animationDuration), () {
      _pullUpController.stop();
    });
  }

  void getUserId() async {
    user_id = await _accountRepository.getSharedPrefs();
  }

  void buttonStateSuccess() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        _buttonState = ButtonState.success;
      });
      Timer(Duration(seconds: 2), () {
        setState(() {
          _buttonState = ButtonState.idle;
        });
      });
    });
  }

  void buttonSatteFailure() {
    setState(() {
      Timer(Duration(seconds: 2), () {
        setState(() {
          _buttonState = ButtonState.fail;
        });
        Timer(Duration(seconds: 2), () {
          setState(() {
            _buttonState = ButtonState.idle;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _pullUpController.dispose();
    super.dispose();
  }
}
// decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(38),
//                                         topRight: Radius.circular(38),
//                                         bottomLeft: Radius.zero,
//                                         bottomRight: Radius.zero),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         offset: Offset(1, -1),
//                                         blurRadius: 4,
//                                         color: IColors.borderShadow,
//                                       )
//                                     ])
