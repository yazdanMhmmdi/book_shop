import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/rating_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VerticalCard extends StatelessWidget {
  String image;
  String name, writer, thumbImage;
  String id;
  double voteCount;
  String description;
  String pagesCount;
  String language;
  String coverType;
  VerticalCard({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.writer,
    @required this.thumbImage,
    @required this.voteCount,
    @required this.pagesCount,
    @required this.coverType,
    @required this.language,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    print("star :  ${voteCount}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 142,
        decoration: BoxDecoration(
            color:
                Color(txfColor).withOpacity(0.15), // TODO: Needs to be replace;
            borderRadius: BorderRadius.circular(8)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.black12,
            onTap: () => Navigator.pushNamed(context, '/details',
                arguments: <String, String>{
                  'post_id': "${id}",
                  'name': "${name}",
                  'writer': "${writer}",
                  'description': "${description}",
                  'voteCount': "${voteCount}",
                  'thumbPicture': "${thumbImage}",
                  'language': "${language}",
                  'coverType': "${coverType}",
                  'pagesCount': "${pagesCount}",
                  'hero_type': "v",
                }),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(11),
                  child: Container(
                    width: 81,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(7, 7),
                            blurRadius: 10)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Hero(
                        tag:
                            "post_${id}_v", //TODO: delete it and add some unrelated posts
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent),
                          child: Image.network(
                              ImageAddressProvider.imageURL + thumbImage),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${name}',
                        style: TextStyle(
                            fontFamily: "IranSans",
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "$writer",
                        style: TextStyle(
                            fontFamily: "IranSans",
                            fontSize: 14,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      MyRatingBar(voteCount, 13),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
