import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/ui/basket_item.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/number_formatter.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketTab extends StatefulWidget {
  @override
  _BasketTabState createState() => _BasketTabState();
}

class _BasketTabState extends State<BasketTab> {
  ButtonState _buttonState = ButtonState.idle;
  BasketBloc _basketBloc;
  double _animationDelay = 0.25;
  bool progress = true;

  @override
  void initState() {
    _basketBloc = BlocProvider.of<BasketBloc>(context);
    _basketBloc.add(GetBasket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BasketBloc, BasketState>(
      listener: (context, state) {
        if (state is BasketSuccess) {
          setState(() {
            progress = false;
            _animationDelay = _animationDelay + 0.3;
          });
        } else {}
      },
      child: progress
          ? Center(
              child: MyLoadingBar(
                animation: 'Untitled',
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 23,
                      ),
                      FadeInAnimation(
                          0.25, MyToolBar(title: Strings.basketLabel)),
                      SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketInitial) {
                            return Container();
                          } else if (state is BasketLoading) {
                            return Container();
                          } else if (state is BasketSuccess) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.basketModel.basket.length,
                                  itemBuilder: (context, index) {
                                    return FadeInAnimation(
                                      _animationDelay,
                                      BasketItem(
                                          id: state
                                              .basketModel.basket[index].id,
                                          image: state.basketModel.basket[index]
                                              .pictureThumb,
                                          name: state
                                              .basketModel.basket[index].name,
                                          writer: state
                                              .basketModel.basket[index].writer,
                                          thumbImage: state.basketModel
                                              .basket[index].pictureThumb,
                                          voteCount: double.parse(state
                                              .basketModel
                                              .basket[index]
                                              .voteCount),
                                          pagesCount: state.basketModel
                                              .basket[index].pagesCount,
                                          coverType: state.basketModel
                                              .basket[index].coverType,
                                          language: state.basketModel
                                              .basket[index].language,
                                          description: state.basketModel
                                              .basket[index].description,
                                          price: state
                                              .basketModel.basket[index].price),
                                    );
                                  }),
                            );
                          } else if (state is BasketFailure) {
                            return Container();
                          } else if (state is BasketEmpty) {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketInitial) {
                            return Container();
                          } else if (state is BasketLoading) {
                            return Container();
                          } else if (state is BasketSuccess) {
                            return payCheckWidget(state);
                          } else if (state is BasketFailure) {
                            return Container();
                          } else if (state is BasketEmpty) {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  TextStyle rightSideTextStyle() {
    return TextStyle(
        fontSize: 16, fontFamily: Strings.fontIranSans, color: IColors.balck35);
  }

  TextStyle leftSideTextStyle() {
    return TextStyle(
        fontSize: 16,
        fontFamily: Strings.fontIranSans,
        color: IColors.balck35,
        fontWeight: FontWeight.w700);
  }

  Widget payCheckWidget(dynamic state) {
    return Column(
      children: [
        FadeInAnimation(
          _animationDelay,
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${Strings.basketPaymentCheck}",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: Strings.fontIranSans,
                    color: IColors.balck85,
                    fontWeight: FontWeight.w700),
              )),
        ),
        SizedBox(height: 8),
        FadeInAnimation(
          0.75,
          Container(
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              color: IColors.lowedBoldGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.basketTax,
                          style: rightSideTextStyle(),
                        ),
                        Text(
                          NumberFormatter.getNumber(state.basketModel.data.tax),
                          style: leftSideTextStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.basketDeliveryCost,
                          style: rightSideTextStyle(),
                        ),
                        Text(
                          NumberFormatter.getNumber(
                              state.basketModel.data.deliveryCost),
                          style: leftSideTextStyle(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.basketPay,
                          style: TextStyle(
                            fontSize: 16,
                            color: IColors.balck85,
                            fontFamily: Strings.fontIranSans,
                          ),
                        ),
                        Text(
                          NumberFormatter.getNumber(
                              state.basketModel.data.fullCost),
                          style: TextStyle(
                              fontSize: 16,
                              color: IColors.boldGreen,
                              fontFamily: Strings.fontIranSans,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    MyButton(
                        buttonState: _buttonState,
                        text: Strings.basketPayit,
                        onTap: () {
                          print('sss');
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
