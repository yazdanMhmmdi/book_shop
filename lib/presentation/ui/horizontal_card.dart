import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatefulWidget {
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
  _HorizontalCardState createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("picture : ${ApiProvider.URL_IP + widget.thumbPicture}");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/details',
              arguments: <String, String>{
                'post_id': "${widget.id}",
                'name': "${widget.name}",
                'writer': "${widget.writer}",
                'description': "${widget.description}",
                'voteCount': "${widget.voteCount}",
                'thumbPicture': "${widget.thumbPicture}",
                'language': "${widget.language}",
                'coverType': "${widget.coverType}",
                'pagesCount': "${widget.pagesCount}",
                'hero_type': "h",
              }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "post_${widget.id}_h",
                child: Container(
                  width: 71,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    ImageAddressProvider.imageURL + widget.thumbPicture,
                  ),
                ),
              ),
              Container(
                width: 71,
                child: Text(
                  '${widget.writer}',
                  overflow: TextOverflow.ellipsis,
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
                width: 71,
                child: Text(
                  '${widget.name}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: "IranSans",
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              MyRatingBar(widget.voteCount, 13),
            ],
          ),
        ),
      ),
    );
  }
}
