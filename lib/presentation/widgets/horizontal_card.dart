import 'package:book_shop/networking/networking.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

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
    required this.id,
    required this.name,
    required this.thumbPicture,
    required this.writer,
    required this.voteCount,
    required this.description,
    required this.coverType,
    required this.pagesCount,
    required this.language,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/details',
              arguments: <String, String>{
                'post_id': id,
                'name': name,
                'writer': writer,
                'description': description,
                'voteCount': voteCount.toString(),
                'thumbPicture': thumbPicture,
                'language': language,
                'coverType': coverType,
                'pagesCount': pagesCount,
                'hero_type': "h",
              }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "post_${id}_h",
                child: Container(
                  width: 71,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: OctoImage(
                      image: CachedNetworkImageProvider(
                        ImageAddressProvider.imageURL + thumbPicture,
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
              SizedBox(
                width: 71,
                child: Text(
                  writer,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black38,
                      fontFamily: "IranSans",
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 71,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: "IranSans",
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
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
