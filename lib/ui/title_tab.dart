import 'package:book_shop/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TitleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 23),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(txfColor),
                        ),
                        child: Icon(Icons.arrow_back,
                            textDirection: TextDirection.rtl,
                            color: Colors.white),
                      ),
                      Center(
                        child: Text(
                          'دسته بندی',
                          style: TextStyle(
                              fontFamily: "IranSans",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: (size.width / (size.height / 2)),
                children: List.generate(6, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(txfColor).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  );
                }),
              ))
        ],
      ),
    );
  }
}
