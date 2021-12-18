import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/ui/basket_item.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/my_button.dart';
import 'package:book_shop/presentation/widgets/my_progress_button.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/not_found_flare.dart';
import 'package:book_shop/presentation/widgets/not_found_widget.dart';
import 'package:book_shop/presentation/widgets/number_formatter.dart';
import 'package:book_shop/presentation/widgets/pay_check_widget.dart';
import 'package:book_shop/presentation/widgets/progress_button.dart';
import 'package:book_shop/presentation/widgets/server_failure_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketTab extends StatefulWidget {
  @override
  State<BasketTab> createState() => _BasketTabState();
}

class _BasketTabState extends State<BasketTab> {
  ButtonState _buttonState = ButtonState.idle;

  late BasketBloc _basketBloc;
  @override
  void initState() {
    _basketBloc = BlocProvider.of<BasketBloc>(context);
    _basketBloc.add(GetBasket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoading) {
          return Center(
            child: MyLoadingBar(
              animation: 'Untitled',
            ),
          );
        } else if (state is BasketSuccess) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.basketModel?.basket.length,
                            itemBuilder: (context, index) {
                              return FadeInAnimation(
                                0.25 + ((index + 1) * 0.3),
                                BasketItem(
                                    onTap: () {
                                      _basketBloc.add(DeleteBasket(
                                          book_id: state
                                              .basketModel!.basket[index].id));
                                    },
                                    id: state.basketModel!.basket[index].id,
                                    image: state.basketModel!.basket[index]
                                        .pictureThumb,
                                    name: state.basketModel!.basket[index].name,
                                    writer:
                                        state.basketModel!.basket[index].writer,
                                    thumbImage: state.basketModel!.basket[index]
                                        .pictureThumb,
                                    voteCount: double.parse(state
                                        .basketModel!.basket[index].voteCount),
                                    pagesCount: state
                                        .basketModel!.basket[index].pagesCount,
                                    coverType: state
                                        .basketModel!.basket[index].coverType,
                                    language: state
                                        .basketModel!.basket[index].language,
                                    description: state
                                        .basketModel!.basket[index].description,
                                    price:
                                        state.basketModel!.basket[index].price),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      PayCheckWidget(
                        tax: state.basketModel!.data.tax,
                        deliveryCost: state.basketModel!.data.deliveryCost,
                        fullCost: state.basketModel!.data.fullCost,
                        buttonState: _buttonState,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is BasketFailure) {
          return ServerFailureFlare();
        } else if (state is BasketEmpty) {
          return NotFoundWidget(
            text: Strings.basketNotFound,
          );
        } else
          return Container();
      },
    );
  }
}
