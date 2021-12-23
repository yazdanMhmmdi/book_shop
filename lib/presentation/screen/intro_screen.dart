import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:book_shop/constants/constants.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];
  late Function goToTab;

  @override
  void initState() {
    slides.add(
      Slide(
        title: Strings.onboardingExploreTitle,
        description: Strings.onboardingExploreDesc,
        pathImage: Assets.onBoardExploreSvg,
      ),
    );
    slides.add(
      Slide(
        title: Strings.onboardingMultiPlatformTitle,
        description: Strings.onboardingMultiPlatformDesc,
        pathImage: Assets.onBoardMultiplatformSvg,
      ),
    );
    slides.add(
      Slide(
        title: Strings.onboardingPaymentTitle,
        description: Strings.onboardingPaymentDesc,
        pathImage: Assets.onBoardPaymentSvg,
      ),
    );
    slides.add(
      Slide(
        title: Strings.onboardingDeliveryTitle,
        description: Strings.onboardingDeliveryDesc,
        pathImage: Assets.onBoardDeliverySvg,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 640),
        orientation: Orientation.portrait);
    return IntroSlider(
      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: IColors.boldGreen,
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: const BouncingScrollPhysics(),

      // Show or hide status bar
      hideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }

  void onDonePress() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (e) => false);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    print(index);
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: IColors.boldGreen,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: IColors.boldGreen,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: IColors.boldGreen,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(IColors.green25),
      overlayColor: MaterialStateProperty.all<Color>(IColors.green25),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0.h, top: 133.0.h),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: SvgPicture.asset(
                currentSlide.pathImage!,
                width: 273.0.w,
                height: 187.0.h,
                fit: BoxFit.contain,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 43.w),
                child: Container(
                  child: Text(
                    currentSlide.title!,
                    style: TextStyle(
                      color: IColors.balck85,
                      fontSize: 22.0.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "IranSans",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 16.0.h),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 43.w),
                child: Container(
                  child: Text(
                    currentSlide.description!,
                    style: TextStyle(
                      color: IColors.balck85,
                      fontSize: 18.0.sp,
                      fontStyle: FontStyle.normal,
                      fontFamily: "IranSans",
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(top: 8.0.h),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }
}
