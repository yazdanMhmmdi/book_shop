// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:book_shop/constants/constants.dart';
import 'package:book_shop/core/utils/throteller.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/circular_indicator.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/no_book_found_widget.dart';
import '../widgets/pagination_loading_widget.dart';

int tabNumber = 1;

class TitleDetailsScreen extends StatefulWidget {
  int category;
  TitleDetailsScreen({required this.category});
  @override
  _TitleDetailsScreenState createState() => _TitleDetailsScreenState();
}

class _TitleDetailsScreenState extends State<TitleDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TitleBloc _sienceTitleBloc;

  ScrollController _controller = ScrollController();
  bool progress = false;
  int firstTabState = 1;
  bool loading = true;
  bool nothingFound = false;
  Color backgroundColor = Colors.white;
  TabController? tabController;
  final double _animationDelay = 0.25;
  int index = 1;

  @override
  void initState() {
    super.initState();
    _getArguments();
    _sienceTitleBloc = BlocProvider.of<TitleBloc>(context);
    _sienceTitleBloc.add(FetchBooks(firstTabState + 1));

    _controller.addListener(() {
      //prevent from calling event twice
      Throttler throttler = Throttler(throttleGapInMillis: 200);
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        throttler.run(() {
          _sienceTitleBloc.add(FetchBooks(tabNumber));
        });
      }
    });

    tabController =
        TabController(length: 6, vsync: this, initialIndex: firstTabState)
          ..addListener(() {
            if (tabController!.indexIsChanging) {
              _sienceTitleBloc.add(FetchBooks(tabController!.index + 1));
              print('tab changed');
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is InternetConnected) {
              return _body();
            } else {
              return NoNetworkFlare();
            }
          },
        ),
      ),
    );
  }

  ScrollConfiguration _body() {
    return ScrollConfiguration(
      behavior: MyCustomScrollBehavior(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: _tabBar(),
                  ),
                  BlocBuilder<TitleBloc, TitleState>(
                    builder: (context, state) {
                      if (state is TitleInitial) {
                        return Container();
                      } else if (state is TitleLoading) {
                        return _loadingBar(context);
                      } else if (state is TitleSuccess) {
                        if (state.model.isEmpty) {
                          return NoBookFoundWidget();
                        } else {
                          return _postsListView(state);
                        }
                      } else if (state is TitleFailure) {
                        return const Text('failure');
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _postsListView(TitleSuccess state) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        ...List<Widget>.from(
          state.model.map((e) => Builder(builder: (context) {
                return FadeInAnimation(
                  _animationDelay + ((index + 1) * 0.3),
                  VerticalCard(
                    model: e,
                  ),
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
      ],
    );
  }

  SizedBox _loadingBar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: MyLoadingBar(animation: "Untitled"),
      ),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      labelColor: IColors.balck85,
      indicator: CircularIndicator(color: Colors.black87, radius: 4),
      labelStyle: const TextStyle(
        fontSize: 22,
        fontFamily: "IranSans",
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        fontFamily: "IranSans",
        fontWeight: FontWeight.w700,
      ),
      controller: tabController,
      tabs: const [
        Tab(
          text: Strings.titleScience,
        ),
        Tab(
          text: Strings.titleMedicine,
        ),
        Tab(
          text: Strings.titleHistoric,
        ),
        Tab(
          text: Strings.titleLaw,
        ),
        Tab(
          text: Strings.titleFood,
        ),
        Tab(
          text: Strings.titleSport,
        ),
      ],
    );
  }

  void _getArguments() {
    firstTabState = widget.category - 1;
  }
}
