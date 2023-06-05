import '../../data/model/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../networking/networking.dart';
import 'widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class BasketItem extends StatelessWidget {
  BookModel bookModel;
  late Function(BuildContext context) onTap;
  BasketItem({
    required this.bookModel,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          MySlidableAction(
            label: 'حذف',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: onTap,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          MySlidableAction(
            label: 'حذف',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: onTap,
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
                    'post_id': bookModel.id!,
                    'name': bookModel.name!,
                    'writer': bookModel.writer!,
                    'description': bookModel.description!,
                    'voteCount': bookModel.voteCount.toString(),
                    'thumbPicture': bookModel.pictureThumb!,
                    'language': bookModel.language!,
                    'coverType': bookModel.coverType!,
                    'pagesCount': bookModel.pagesCount!,
                    'hero_type': "v",
                    'price': bookModel.price.toString(),
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
                              offset: const Offset(7, 7),
                              blurRadius: 10)
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Hero(
                          tag: "post_${bookModel.id}_v",
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  ImageAddressProvider.imageURL +
                                      bookModel.pictureThumb!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 26),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bookModel.name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontFamily: "IranSans",
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  bookModel.writer!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: "IranSans",
                                      fontSize: 14,
                                      color: Colors.black38),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                MyRatingBar(bookModel.voteCount!, 13),
                              ],
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                child: Text(
                                  NumberFormat("#,##0.##").format(double.parse(
                                          bookModel.price.toString())) +
                                      " تومان",
                                  style: const TextStyle(
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
