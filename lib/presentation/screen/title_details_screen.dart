import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/circular_indicator.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/logic.dart';
import 'package:book_shop/constants/constants.dart';

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
  @override
  void initState() {
    super.initState();
    _getArguments();
    _sienceTitleBloc = BlocProvider.of<TitleBloc>(context);
    _sienceTitleBloc.add(FetchBooks(firstTabState + 1));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _sienceTitleBloc.add(PaginationBooks(tabNumber));
      }
    });

    tabController =
        TabController(length: 6, vsync: this, initialIndex: firstTabState)
          ..addListener(() {
            _sienceTitleBloc.add(FetchBooks(tabController!.index + 1));
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocListener<TitleBloc, TitleState>(listener: (context, state) {
          if (state is TitlePagination) {
            setState(() {
              progress = true;
            });
          } else if (state is TitleSuccess) {
            setState(() {
              progress = false;
              loading = false;
              nothingFound = false;
            });
          } else if (state is TitleLoading) {
            setState(() {
              loading = true;
              nothingFound = false;
            });
          } else if (state is TitleNothingFound) {
            setState(() {
              loading = false;
              nothingFound = true;
            });
          }
        }, child: BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state is InternetConnected) {
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
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 8),
                              child: TabBar(
                                isScrollable: true,
                                unselectedLabelColor: Colors.grey,
                                labelColor: IColors.balck85,
                                indicator: CircularIndicator(
                                    color: Colors.black87, radius: 4),
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
                              ),
                              // TitleSelector(
                              //   titles: const [
                              //     Strings.titleScience,
                              //     Strings.titleMedicine,
                              //     Strings.titleHistoric,
                              //     Strings.titleLaw,
                              //     Strings.titleFood,
                              //     Strings.titleSport
                              //   ],
                              //   bloc: _sienceTitleBloc,
                              //   firstTab: firstTabState,
                              // ),
                            ),
                            BlocBuilder<TitleBloc, TitleState>(
                              builder: (context, state) {
                                if (state is TitleInitial) {
                                  return Container();
                                } else if (state is TitleLoading) {
                                  return Container();
                                } else if (state is TitleSuccess) {
                                  return TitleDetailsTab(state.model);
                                } else if (state is TitleFailure) {
                                  return const Text('failure');
                                } else if (state is TitleNothingFound) {
                                  return Container();
                                } else if (state is TitlePagination) {
                                  return TitleDetailsTab(state.model);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            progress
                                ? const Padding(
                                    padding: EdgeInsets.only(bottom: 8, top: 4),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          IColors.boldGreen),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        loading
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: MyLoadingBar(animation: "Untitled"),
                                ),
                              )
                            : Container(),
                        nothingFound
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: SizedBox(
                                    width: 170,
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          NotFoundFlare(),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          FadeInAnimation(
                                            0.5,
                                            const Text(
                                              Strings.bookNotFound,
                                              style: TextStyle(
                                                  fontFamily: "IranSans",
                                                  fontSize: 18,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return NoNetworkFlare();
            }
          },
        )),
      ),
    );
  }

  void _getArguments() {
    firstTabState = widget.category - 1;
  }
}
