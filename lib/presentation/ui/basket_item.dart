import 'package:book_shop/presentation/widgets/my_slide_action.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/rating_bar.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class BasketItem extends StatelessWidget {
  String image;
  String name, writer, thumbImage;
  String id;
  double voteCount;
  String description;
  String pagesCount;
  String language;
  String coverType;
  String price;
  late Function() onTap;
  BasketItem({
    required this.id,
    required this.image,
    required this.name,
    required this.writer,
    required this.thumbImage,
    required this.voteCount,
    required this.pagesCount,
    required this.coverType,
    required this.language,
    required this.description,
    required this.price,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Archive',
            backgroundColor: Colors.blue,
            icon: Icons.archive,
            onPressed: (context) {},
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          MyIconSlideAction(
            iconWidget: Text("iconWidget"),
            caption: 'حذف',
            color: Colors.red,
            icon: Icons.delete,
            actionBorderRadius: 8,
            onTap: onTap,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          height: 142,
          decoration: BoxDecoration(
              color: Color(txfColor)
                  .withOpacity(0.15), // TODO: Needs to be replace;
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
                    'price': '${price}',
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
                          tag: "post_${id}_v",
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  ImageAddressProvider.imageURL + thumbImage,
                                ),
                              ),
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
      ),
    );
  }
}
