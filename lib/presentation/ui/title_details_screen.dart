import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/title_bloc.dart';
import 'package:book_shop/presentation/ui/title_tab.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:book_shop/presentation/widgets/title_details_tab.dart';
import 'package:book_shop/presentation/widgets/title_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';

int tabNumber = 1;

class TitleDetailsScreen extends StatefulWidget {
  @override
  _TitleDetailsScreenState createState() => _TitleDetailsScreenState();
}

class _TitleDetailsScreenState extends State<TitleDetailsScreen> {
  TitleBloc _sienceTitleBloc;

  TitleBloc _medicineTitleBloc;

  ScrollController _controller = new ScrollController();
  bool progress = false;
  int firstTabState = 1;
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
    Map<String, String> arguments = ModalRoute.of(context).settings.arguments;

    setState(() {
      print('titleDetails argument : ');
      firstTabState = int.tryParse(arguments["category"]);
    });
    return Scaffold(
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
              });
            }
          },
          child: SingleChildScrollView(
            controller: _controller,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
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
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is TitleSuccess)
                        return TitleDetailsTab(state.model);
                      else if (state is TitleFailure) {
                        return Text('failureXXX');
                      } else if (state is TitleNothingFound) {
                        return Text('چیزی پیدا نشد');
                      } else if (state is TitlePagination) {
                        return TitleDetailsTab(state.model);
                      }
                    },
                  ),
                  progress ? CircularProgressIndicator() : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
