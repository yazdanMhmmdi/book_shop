import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:book_shop/constants/constants.dart';

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
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 23,
                      ),
                      FadeInAnimation(
                          0.25, MyToolBar(title: Strings.basketLabel)),
                      const SizedBox(
                        height: 16,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.basketModel?.basket.length,
                            itemBuilder: (context, index) {
                              return FadeInAnimation(
                                0.25 + ((index + 1) * 0.3),
                                BasketItem(
                                    onTap: (context) {
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
                      const SizedBox(
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
        } else {
          return Container();
        }
      },
    );
  }
}
