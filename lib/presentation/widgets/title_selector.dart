import 'package:flutter/material.dart';

class TitleSelector extends StatefulWidget {
  List<String> titles;
  TitleSelector({@required this.titles});
  @override
  _TitleSelectorState createState() => _TitleSelectorState();
}

/*
Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black87,
              ),
*/
class _TitleSelectorState extends State<TitleSelector> {
  int _currentIndex = 0;
  bool _isSelected;
  double _rightPadding = 15;
  int temp = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 43,
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          Stack(
            children: [
              Row(
                children: _titleSelector(),
              ),
              AnimatedPositioned(
                  bottom: 2,
                  right: _rightPadding,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black87,
                    ),
                  ),
                  duration: Duration(milliseconds: 300))
            ],
          )
        ]),
      ),
    );
  }

  List<Widget> _titleSelector() {
    return widget.titles.map((e) {
      var index = widget.titles.indexOf(e);
      _isSelected = _currentIndex == index;
      return Padding(
        padding: EdgeInsets.only(left: 35),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
              print('cu : $_currentIndex and indx: $index temp = $temp');
              int c = index;
              print(c);

              if (temp > index) {
                c = temp - c;
                if (c <= 0) {
                  _rightPadding -= 70;
                } else {
                  _rightPadding = _rightPadding - (c * 70);
                }
              } else {
                c = c - temp;
                print(c);
                if (c <= 0) {
                  _rightPadding += 70;
                } else {
                  _rightPadding = (c * 70) + _rightPadding;
                }
              }
              temp = index;
            });
          },
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              e,
              style: TextStyle(
                color: _isSelected ? Colors.black87 : Colors.grey,
                fontSize: _isSelected ? 22 : 16,
                fontFamily: "IranSans",
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        ),
      );
    }).toList();
  }
}
