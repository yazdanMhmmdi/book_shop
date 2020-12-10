import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/title_bloc.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/ui/title_tab.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/no_network_flare.dart';
import 'package:book_shop/presentation/widgets/not_found_bar.dart';
import 'package:book_shop/presentation/widgets/title_details_tab.dart';
import 'package:book_shop/presentation/widgets/title_selector.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

int tabNumber = 1;

class TitleDetailsScreen extends StatefulWidget {
  int category;
  TitleDetailsScreen({@required this.category});
  @override
  _TitleDetailsScreenState createState() => _TitleDetailsScreenState();
}

class _TitleDetailsScreenState extends State<TitleDetailsScreen> {
  TitleBloc _sienceTitleBloc;

  TitleBloc _medicineTitleBloc;

  ScrollController _controller = new ScrollController();
  bool progress = false;
  int firstTabState = 1;
  bool loading = true;
  bool nothingFound = false;
  Color backgroundColor = Colors.white;
  @override
  void initState() {
    super.initState();

    _sienceTitleBloc = context.bloc<TitleBloc>();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _sienceTitleBloc.add(PaginationBooks(tabNumber));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      print('titleDetails argument : ');
      firstTabState = widget.category;
    });
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocListener<TitleBloc, TitleState>(
            cubit: _sienceTitleBloc,
            listener: (context, state) {
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
            },
            child: BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected) {
                  return SingleChildScrollView(
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
                                  titles: [
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
                                  } else if (state is TitleSuccess)
                                    return TitleDetailsTab(state.model);
                                  else if (state is TitleFailure) {
                                    return Text('failure');
                                  } else if (state is TitleNothingFound) {
                                    return Container();
                                  } else if (state is TitlePagination) {
                                    return TitleDetailsTab(state.model);
                                  }
                                },
                              ),
                              progress
                                  ? CircularProgressIndicator()
                                  : Container(),
                            ],
                          ),
                          loading
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child:
                                        new MyLoadingBar(animation: "Untitled"),
                                  ),
                                )
                              : Container(),
                          nothingFound
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Container(
                                      width: 150,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            NotFoundBar(),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text('ss'),
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
