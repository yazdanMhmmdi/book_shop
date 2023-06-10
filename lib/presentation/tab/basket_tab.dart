import 'package:book_shop/presentation/widgets/custom_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../core/utils/throteller.dart';
import '../../logic/logic.dart';
import '../animation/animation.dart';
import '../widgets/pagination_loading_widget.dart';
import '../widgets/widgets.dart';

class BasketTab extends StatefulWidget {
  @override
  State<BasketTab> createState() => _BasketTabState();
}

class _BasketTabState extends State<BasketTab> {
  ButtonState _buttonState = ButtonState.idle;
  int index = 1;
  late BasketBloc _basketBloc;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _basketBloc = BlocProvider.of<BasketBloc>(context);
    _basketBloc.add(GetBasket());
    super.initState();

    _onScrollPaginationListener();
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
                        child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: _controller,
                            children: [
                              ...List<Widget>.from(
                                state.basketModel!.map((e) =>
                                    Builder(builder: (context) {
                                      return FadeInAnimation(
                                        0.25 + ((index + 1) * 0.3),
                                        BasketItem(
                                            onTap: (context) {
                                              _basketBloc.add(
                                                  DeleteBasket(book_id: e.id!));
                                            },
                                            bookModel: e),
                                      );
                                    })),
                              ),
                              if (state.noMoreData) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Column(
                                    children: [
                                      PaginationLoadingWidget(),
                                    ],
                                  ),
                                ),
                              ]
                            ]),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      PayCheckWidget(
                        tax: state.basketDataModel!.tax!,
                        deliveryCost: state.basketDataModel!.deliveryCost!,
                        fullCost: state.basketDataModel!.fullCost!,
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

  _onScrollPaginationListener() {
    _controller.addListener(() {
      //prevent from calling event twice
      Throttler throttler = Throttler(throttleGapInMillis: 200);
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        throttler.run(() {
          _basketBloc.add(GetBasket());
        });
      }
    });
  }
}
