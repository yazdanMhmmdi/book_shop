import 'package:flutter/material.dart';

class BackgroundFadeTransition extends StatefulWidget {
  var child;
  var status;
  BackgroundFadeTransition({@required this.child, @required this.status});
  @override
  _BackgroundFadeTransitionState createState() =>
      _BackgroundFadeTransitionState();
}

class _BackgroundFadeTransitionState extends State<BackgroundFadeTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 1000,
        ));
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.status
        ? FadeTransition(
            opacity: _animationController,
            child: widget.child,
          )
        : FadeTransition(
            opacity: _animationController,
            child: widget.child,
          );
  }
}
