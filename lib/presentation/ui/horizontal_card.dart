import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  String id;
  String writer;
  String name;
  String thumbPicture;
  double voteCount;
  String description;
  String pagesCount;
  String language;
  String coverType;
  HorizontalCard({
    @required this.id,
    @required this.name,
    @required this.thumbPicture,
    @required this.writer,
    @required this.voteCount,
    @required this.description,
    @required this.coverType,
    @required this.pagesCount,
    @required this.language,
  });
  @override
  Widget build(BuildContext context) {
    print("picture : ${ApiProvider.URL_IP + thumbPicture}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/details',
              arguments: <String, String>{
                'post_id': "${id}",
                'name': "${name}",
                'writer': "${writer}",
                'description': "${description}",
                'voteCount': "${voteCount}",
                'thumbPicture': "${thumbPicture}",
                'language': "${language}",
                'coverType': "${coverType}",
                'pagesCount': "${pagesCount}",
              }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "post_${id}",
                child: Container(
                  width: 71,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    ImageAddressProvider.imageURL + thumbPicture,
                  ),
                ),
              ),
              Container(
                width: 71,
                child: Text(
                  '${writer}',
                  style: TextStyle(
                      color: Colors.black38,
                      fontFamily: "IranSans",
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: 111,
                child: Text(
                  '${name}',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "IranSans",
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              MyRatingBar(voteCount, 13),
            ],
          ),
        ),
      ),
    );
  }
}
