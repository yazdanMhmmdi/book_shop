import '../../constants/constants.dart';
import '../../data/model/book_model.dart';
import '../../networking/networking.dart';
import 'widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';

class VerticalCard extends StatelessWidget {
  BookModel? model;
  VerticalCard({this.model});

  @override
  Widget build(BuildContext context) {
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
                  'post_id': model!.id!,
                  'name': model!.name!,
                  'writer': model!.writer!,
                  'description': model!.description!,
                  'voteCount': model!.voteCount!.toString(),
                  'thumbPicture': model!.pictureThumb!,
                  'language': model!.language!,
                  'coverType': model!.coverType!,
                  'pagesCount': model!.pagesCount!,
                  'hero_type': "v",
                  'price': model!.price!.toString(),
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
                        tag: "post_${model!.id}_v",
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: OctoImage(
                              image: CachedNetworkImageProvider(
                                ImageAddressProvider.imageURL +
                                    model!.pictureThumb!,
                              ),
                              placeholderBuilder: OctoPlaceholder.blurHash(
                                model!.blurhash!,
                              ),
                              errorBuilder: OctoError.icon(color: Colors.red),
                              fit: BoxFit.cover,
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
                                model!.name!,
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
                                model!.writer!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: "IranSans",
                                    fontSize: 14,
                                    color: Colors.black38),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MyRatingBar(model!.voteCount!, 13),
                            ],
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: Text(
                                NumberFormat("#,##0.##").format(model!.price) +
                                    " تومان", //TODO: replace hardcoded.
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
    );
  }
}
