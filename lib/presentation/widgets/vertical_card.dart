import 'package:book_shop/constants/constants.dart';
import 'package:book_shop/networking/networking.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';

class VerticalCard extends StatelessWidget {
  String image;
  String name, writer, thumbImage;
  String id;
  double voteCount;
  String description;
  String pagesCount;
  String language;
  String coverType;
  String price;
  VerticalCard({
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
  });

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
                  'post_id': id,
                  'name': name,
                  'writer': writer,
                  'description': description,
                  'voteCount': voteCount.toString(),
                  'thumbPicture': thumbImage,
                  'language': language,
                  'coverType': coverType,
                  'pagesCount': pagesCount,
                  'hero_type': "v",
                  'price': price,
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
                        tag: "post_${id}_v",
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
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
                                name,
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
                                writer,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: "IranSans",
                                    fontSize: 14,
                                    color: Colors.black38),
                              ),
                              const SizedBox(
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
