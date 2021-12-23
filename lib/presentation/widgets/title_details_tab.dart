import 'package:book_shop/constants/constants.dart';
import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/presentation/animation/animation.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TitleDetailsTab extends StatelessWidget {
  final List<Books> _books;
  final double _animationDelay = 0.25;
  TitleDetailsTab(this._books);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _books.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return FadeInAnimation(
          _animationDelay + ((index + 1) * 0.3),
          VerticalCard(
            image: Assets.sampleImage_1,
            name: _books[index].name,
            id: _books[index].id,
            writer: _books[index].writer,
            thumbImage: _books[index].pictureThumb,
            voteCount: _books[index].voteCount,
            coverType: _books[index].coverType,
            description: _books[index].description,
            language: _books[index].language,
            pagesCount: _books[index].pagesCount,
            price: _books[index].price,
          ),
        );
      },
    );
  }
}
