import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/title_bloc.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/not_found_flare.dart';
import 'package:book_shop/presentation/widgets/title_details_tab.dart';
import 'package:book_shop/presentation/widgets/title_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int tabNumber = 1;

class TitleDetailsScreen extends StatefulWidget {
  int category;
  TitleDetailsScreen({required this.category});
  @override
  _TitleDetailsScreenState createState() => _TitleDetailsScreenState();
}

class _TitleDetailsScreenState extends State<TitleDetailsScreen> {
  late TitleBloc _sienceTitleBloc;

  ScrollController _controller = ScrollController();
  bool progress = false;
  int firstTabState = 1;
  bool loading = true;
  bool nothingFound = false;
  Color backgroundColor = Colors.white;
  @override
  void initState() {
    super.initState();

    _sienceTitleBloc = BlocProvider.of<TitleBloc>(context);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _sienceTitleBloc.add(PaginationBooks(tabNumber));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      firstTabState = widget.category;
    });
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
                              child: TitleSelector(
                                titles: const [
                                  Strings.titleScience,
                                  Strings.titleMedicine,
                                  Strings.titleHistoric,
                                  Strings.titleLaw,
                                  Strings.titleFood,
                                  Strings.titleSport
                                ],
                                bloc: _sienceTitleBloc,
                                firstTab: firstTabState,
                              ),
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
}
