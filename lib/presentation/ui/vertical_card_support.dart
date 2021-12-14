import 'package:book_shop/constants/assets.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/customer_agent_widget.dart';
import 'package:book_shop/presentation/widgets/new_message_notify.dart';
import 'package:book_shop/presentation/widgets/rating_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';

class VerticalCardSupport extends StatelessWidget {
  String image;
  String name, writer, thumbImage;
  String id;
  double voteCount;
  String price;
  String newMessageCount;
  String userId;
  VerticalCardSupport({
    required this.id,
    required this.image,
    required this.name,
    required this.writer,
    required this.thumbImage,
    required this.voteCount,
    required this.price,
    required this.newMessageCount,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    print("star :  ${voteCount}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Container(
            height: 142,
            decoration: BoxDecoration(
                color: Color(txfColor).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                splashColor: Colors.black12,
                onTap: () => Navigator.pushNamed(context, '/chat',
                    arguments: <String, String>{
                      'post_id': "${id}",
                      'name': "${name}",
                      'writer': "${writer}",
                      'voteCount': "${voteCount}",
                      'thumbPicture': "${thumbImage}",
                      'hero_type': "v",
                      'price': '${price}',
                      'user_id': "${userId}",
                    }),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Hero(
                        tag: "post_${id}_v",
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.transparent,
                              ),
                              child: OctoImage(
                                image: CachedNetworkImageProvider(
                                  ImageAddressProvider.imageURL + thumbImage,
                                ),
                                placeholderBuilder: OctoPlaceholder.blurHash(
                                  'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                ),
                                errorBuilder: OctoError.icon(color: Colors.red),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 26),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      '${name}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontFamily: "IranSans",
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "$writer",
                                    overflow: TextOverflow.ellipsis,
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
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Text(
                                    NumberFormat("#,##0.##")
                                            .format(double.parse(price)) +
                                        " تومان",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: Strings.fontIranSans,
                                        color: IColors.boldGreen,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 58,
            top: 5,
            child: Hero(tag: 'post_${id}_agent', child: CustomerAgentWidget()),
          ),
          newMessageCount == "0" ? Container() : Container()

          //NewMessageNotify(newMessageCount: "$newMessageCount"),
        ],
      ),
    );
  }
}
