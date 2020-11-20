import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  String image;
  String name, writer, thumbImage;
  String id;
  VerticalCard(
      {@required this.id,
      @required this.image,
      @required this.name,
      @required this.writer,
      @required this.thumbImage});

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
                arguments: <String, String>{'post_id': "${id}"}),
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
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red),
                        child: Image.network(
                            ImageAddressProvider.imageURL + thumbImage),
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
