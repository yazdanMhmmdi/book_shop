// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';

// enum ButtonState { idle, loading, success, fail }

// class ProgressButton extends StatefulWidget {
//   final Map<ButtonState, Widget> stateWidgets;
//   final Map<ButtonState, Color> stateColors;
//   final Function() onPressed;
//   Function onAnimationEnd;
//   ButtonState state;
//   final minWidth;
//   final maxWidth;
//   double radius;
//   final height;
//   final CircularProgressIndicator progressIndicator;
//   final MainAxisAlignment progressIndicatorAligment;
//   final EdgeInsets padding;

//   ProgressButton({
//     // required Key key,
//     required this.stateWidgets,
//     required this.stateColors,
//     this.state = ButtonState.idle,
//     required this.onPressed,
//     required this.onAnimationEnd,
//     this.minWidth = 200.0,
//     this.maxWidth = 400.0,
//     this.radius = 16.0,
//     this.height = 53.0,
//     required this.progressIndicator,
//     this.progressIndicatorAligment = MainAxisAlignment.spaceBetween,
//     this.padding = EdgeInsets.zero,
//   })  : assert(
//           stateWidgets != null &&
//               stateWidgets.keys.toSet().containsAll(ButtonState.values.toSet()),
//           'Must be non-null widgetds provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(stateWidgets.keys.toSet())}',
//         ),
//         assert(
//           stateColors != null &&
//               stateColors.keys.toSet().containsAll(ButtonState.values.toSet()),
//           'Must be non-null widgetds provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(stateColors.keys.toSet())}',
//         );
//   // super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _ProgressButtonState();
//   }

//   factory ProgressButton.icon({
//     required Map<ButtonState, IconedButton> iconedButtons,
//     required Function() onPressed,
//     ButtonState state = ButtonState.idle,
//     required Function animationEnd,
//     maxWidth: 170.0,
//     minWidth: 58.0,
//     height: 30.0,
//     radius: 100.0,
//     double iconPadding: 4.0,
//     TextStyle? textStyle,
//     required CircularProgressIndicator progressIndicator,
//     MainAxisAlignment? progressIndicatorAligment,
//     EdgeInsets padding = EdgeInsets.zero,
//   }) {
//     assert(
//       iconedButtons != null &&
//           iconedButtons.keys.toSet().containsAll(ButtonState.values.toSet()),
//       'Must be non-null widgets provided in map of stateWidgets. Missing keys => ${ButtonState.values.toSet().difference(iconedButtons.keys.toSet())}',
//     );

//     if (textStyle == null) {
//       textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
//     }

//     Map<ButtonState, Widget> stateWidgets = {
//       ButtonState.idle: buildChildWithIcon(
//           iconedButtons[ButtonState.idle]!, iconPadding, textStyle),
//       ButtonState.loading: Column(),
//       ButtonState.fail: buildChildWithIcon(
//           iconedButtons[ButtonState.fail]!, iconPadding, textStyle),
//       ButtonState.success: buildChildWithIcon(
//           iconedButtons[ButtonState.success]!, iconPadding, textStyle)
//     };

//     Map<ButtonState, Color> stateColors = {
//       ButtonState.idle: iconedButtons[ButtonState.idle]!.color,
//       ButtonState.loading: iconedButtons[ButtonState.loading]!.color,
//       ButtonState.fail: iconedButtons[ButtonState.fail]!.color,
//       ButtonState.success: iconedButtons[ButtonState.success]!.color,
//     };

//     return ProgressButton(
//       stateWidgets: stateWidgets,
//       stateColors: stateColors,
//       state: state,
//       onPressed: onPressed,
//       onAnimationEnd: animationEnd,
//       maxWidth: maxWidth,
//       minWidth: minWidth,
//       radius: radius,
//       height: height,
//       progressIndicatorAligment: MainAxisAlignment.center,
//       progressIndicator: progressIndicator,
//     );
//   }
// }

// class _ProgressButtonState extends State<ProgressButton>
//     with TickerProviderStateMixin {
//   AnimationController? colorAnimationController;
//   late Animation<Color?> colorAnimation;
//   late double? width;
//   Duration animationDuration = Duration(milliseconds: 500);
//   late Widget? progressIndicator;

//   void startAnimations(ButtonState oldState, ButtonState newState) {
//     Color? begin = widget.stateColors[oldState];
//     Color? end = widget.stateColors[newState];
//     if (newState == ButtonState.loading) {
//       width = widget.minWidth;
//       widget.radius = 100;
//     } else if (newState == ButtonState.idle) {
//       width = widget.maxWidth;
//       widget.radius = 8;
//     } else if (newState == ButtonState.fail) {
//       width = widget.minWidth;
//       widget.radius = 100;
//       Timer(Duration(seconds: 2), () {
//         setState(() {
//           widget.state = ButtonState.idle;
//           width = MediaQuery.of(context).size.width;
//           widget.radius = 8;
//         });
//       });
//     } else if (newState == ButtonState.success) {
//       width = widget.minWidth;
//       widget.radius = 100;
//       // Timer(Duration(seconds: 2), () {
//       //   setState(() {
//       //     widget.state = ButtonState.idle;
//       //     width = MediaQuery.of(context).size.width;
//       //     widget.radius = 8;
//       //   });
//       // });
//     } else {}
//     colorAnimation = ColorTween(begin: begin, end: end).animate(CurvedAnimation(
//       parent: colorAnimationController!,
//       curve: Interval(
//         0,
//         1,
//         curve: Curves.easeIn,
//       ),
//     ));
//     colorAnimationController!.forward();
//   }

//   Color? get backgroundColor => widget.stateColors[widget.state];

//   @override
//   void initState() {
//     super.initState();

//     width = widget.maxWidth;

//     colorAnimationController =
//         AnimationController(duration: animationDuration, vsync: this);
//     colorAnimationController!.addStatusListener((status) {
//       if (widget.onAnimationEnd != null) {
//         widget.onAnimationEnd(status, widget.state);
//       }
//     });

//     progressIndicator = widget.progressIndicator;
//   }

//   @override
//   void dispose() {
//     colorAnimationController!.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(ProgressButton oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (oldWidget.state != widget.state) {
//       colorAnimationController!.reset();
//       startAnimations(oldWidget.state, widget.state);
//     }
//   }

//   Widget getButtonChild(bool visibility) {
//     Widget buttonChild = widget.stateWidgets[widget.state]!;
//     if (widget.state == ButtonState.loading) {
//       return Row(
//         mainAxisAlignment: widget.progressIndicatorAligment,
//         children: <Widget>[progressIndicator!, buttonChild, Container()],
//       );
//     }
//     return AnimatedOpacity(
//         opacity: visibility ? 1.0 : 0.0,
//         duration: Duration(milliseconds: 250),
//         child: buttonChild);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: colorAnimationController!,
//       builder: (context, child) {
//         return AnimatedContainer(
//             width: width,
//             height: widget.height,
//             duration: animationDuration,
//             child: RaisedButton(
//               padding: widget.padding,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(widget.radius),
//                   side: BorderSide(color: Colors.transparent, width: 0)),
//               color: backgroundColor,
//               onPressed: widget.onPressed,
//               child: getButtonChild(
//                   colorAnimation == null ? true : colorAnimation.isCompleted),
//             ));
//       },
//     );
//   }
// }
