import 'dart:math';

import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/presentation/widgets/detail_slider_widget/detail_slider_container.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailSliderWidget extends StatefulWidget {
  Duration duration;
  List<DetailSliderContainer> sliderContainers;
  DetailSliderWidget({
    required this.sliderContainers,
    this.duration = const Duration(milliseconds: 350),
  });
  @override
  _SliderObjectState createState() => _SliderObjectState();
}

class _SliderObjectState extends State<DetailSliderWidget> {
  // slider Animation
  Color _sliderLeftTextColor = Colors.black38;
  Color _sliderRightTextColor = Colors.black87;
  AlignmentGeometry _sliderObjectAlignment = Alignment.centerRight;
  CarouselController _pageCarouselController = CarouselController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    sliderAnimationRightClicked();
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: widget.duration,
                    child: Text(
                      Strings.detailAboutBook,
                    ),
                    style: TextStyle(
                        fontFamily: "iranSans",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _sliderRightTextColor),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                sliderAnimationLeftClicked();
              },
              child: AnimatedDefaultTextStyle(
                duration: widget.duration,
                child: Text(
                  Strings.detailABoutPublisher,
                ),
                style: TextStyle(
                    fontFamily: "iranSans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _sliderLeftTextColor),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            AnimatedAlign(
              duration: widget.duration,
              alignment: _sliderObjectAlignment,
              curve: Curves.ease,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 58,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: IColors.boldGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        AbsorbPointer(
          child: CarouselSlider(
            carouselController: _pageCarouselController,
            options: CarouselOptions(
                onPageChanged: null,
                disableCenter: true,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
                height: 90,
                autoPlayCurve: Curves.ease,
                viewportFraction: 1,
                initialPage: 1,
                enableInfiniteScroll: false),
            items: widget.sliderContainers,
          ),
        ),
      ],
    );
  }

  void sliderAnimationLeftClicked() {
    setState(() {
      _sliderLeftTextColor = Colors.black87;
      _sliderRightTextColor = Colors.black38;
      _sliderObjectAlignment = Alignment.centerLeft;
      _pageCarouselController.previousPage(
          duration: widget.duration, curve: Curves.ease);
    });
  }

  void sliderAnimationRightClicked() {
    setState(() {
      _sliderLeftTextColor = Colors.black38;
      _sliderRightTextColor = Colors.black87;
      _sliderObjectAlignment = Alignment.centerRight;
      _pageCarouselController.nextPage(
          duration: widget.duration, curve: Curves.ease);
    });
  }
}