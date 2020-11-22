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

class TitleDetailsScreen extends StatelessWidget {
  TitleBloc _sienceTitleBloc;
  TitleBloc _medicineTitleBloc;

  @override
  Widget build(BuildContext context) {
    _sienceTitleBloc = context.bloc<TitleBloc>();
    ScreenUtil.init(context, designSize: Size(360, 735));
    _sienceTitleBloc.add(FetchBooks(1));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      Strings.titleLaw,
                      Strings.titleHistoric,
                      Strings.titleFood,
                      Strings.titleSport
                    ],
                    bloc: _sienceTitleBloc,
                  ),
                ),
                BlocBuilder<TitleBloc, TitleState>(
                  builder: (context, state) {
                    if (state is TitleInitial) {
                      return Container();
                    } else if (state is TitleLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TitleSuccess)
                      return TitleDetailsTab(state.model);
                    else if (state is TitleFailure) {
                      return Text('failureXXX');
                    }
                    else if (state is TitleNothingFound) {
                      return Text('چیزی پیدا نشد');
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
}
