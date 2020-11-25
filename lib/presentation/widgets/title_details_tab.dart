import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/data/model/title_model.dart';
import 'package:book_shop/presentation/ui/vertical_card.dart';
import 'package:flutter/material.dart';

class TitleDetailsTab extends StatelessWidget {
  List<Books> _books = new List<Books>();
  TitleDetailsTab(this._books);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _books.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return VerticalCard(
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
        );
      },
    );
  }
}
