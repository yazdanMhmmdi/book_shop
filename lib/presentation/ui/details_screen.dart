import 'dart:async';
import 'dart:math';

import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/details_bloc.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/animation/background_fade_transition.dart';
import 'package:book_shop/presentation/animation/pull_up_transition.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:book_shop/presentation/widgets/slider_object.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  Map<String, String> args;
  DetailsScreen({@required this.args});
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  DetailsBloc _detailsBloc;
  String voteCount;
  String description;
  String pagesCount;
  String language;
  String coverType;
  String thumbPicture;
  String name;
  String writer;
  String price;
  String id;
  Map<String, String> arguments;
  ButtonState _buttonState = ButtonState.idle;
  Color backgroundColor = IColors.green;
  bool _pullUpAnimationFlag = true;
  bool _fadeAnimationFlag = true;
  AnimationController _pullUpController;

  Random _random = new Random();
  int _randAge, _randBookCount, _randCategory, _randVote;

  ///
  int _animationDuration = 300;

  @override
  void initState() {
    _pullUpController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));

    _pullUpController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arguments = widget.args;
    // _detailsBloc.add(GetDetails(post_id: arguments["post_id"]));
    _getArguments();
    return WillPopScope(
      onWillPop: () {
        _pullDownAnimation();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: BlocConsumer<InternetCubit, InternetState>(
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
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, right: 24),
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
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 135),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset(0, 1), end: Offset.zero)
                              .animate(_pullUpController),
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 112),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              "${writer}",
                                              style: TextStyle(
                                                  fontFamily: "iranSans",
                                                  fontSize: 20,
                                                  color: Colors.black38),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "${name}",
                                              style: TextStyle(
                                                  fontFamily: "iranSans",
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87),
                                              textAlign: TextAlign.center,
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
                                      SliderObject(
                                        coverType: coverType,
                                        voteCount: voteCount,
                                        pageCount: pagesCount,
                                        language: language,
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        Strings.detailsDescription,
                                        style: TextStyle(
                                            fontFamily: "iranSans",
                                            fontSize: 20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        '${description} ',
                                        style: TextStyle(
                                            fontFamily: "iranSans",
                                            fontSize: 16,
                                            height: 1.4,
                                            color: IColors.balck35),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      MyButton(
                                          buttonState: _buttonState,
                                          text: Strings.detailsBuy,
                                          onTap: () {
                                            print('sss');
                                          }),
                                      SizedBox(
                                        height: 45,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(38),
                                    topRight: Radius.circular(38),
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(1, -1),
                                    blurRadius: 4,
                                    color: IColors.borderShadow,
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 87,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 12),
                                          blurRadius: 22,
                                          color: Colors.black.withOpacity(0.25))
                                    ]),
                              ),
                              Hero(
                                tag:
                                    "post_${id}_${arguments["hero_type"]}", //TODO: check hero types
                                child: Container(
                                  width: 136,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent),
                                  child: Image.network(
                                    //TODO: change pictureThumb to picture cause of quality
                                    ImageAddressProvider.imageURL +
                                        thumbPicture,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return NoNetworkFlare();
            }
          }),
        ),
      ),
    );
  }

  Widget myButton(Function onTap) {
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
    description = arguments['description'];
    pagesCount = arguments['pagesCount'];
    language = arguments['language'];
    coverType = arguments['coverType'];
    thumbPicture = arguments['thumbPicture'];
    id = arguments["post_id"];
    writer = arguments['writer'];
    voteCount = arguments['voteCount'];
    name = arguments['name'];
    price = arguments['price'];
  }

  void _pullDownAnimation() {
    Navigator.pop(context);

    _pullUpController.repeat(reverse: true);
    Timer(Duration(milliseconds: _animationDuration), () {
      _pullUpController.stop();
    });
  }
}
