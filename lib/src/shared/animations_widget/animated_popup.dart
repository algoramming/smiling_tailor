import 'package:flutter/material.dart';

import '../../config/constants.dart';

class AnimatedPopup extends StatefulWidget {
  const AnimatedPopup({super.key, required this.child});

  final Widget child;

  @override
  State<AnimatedPopup> createState() => _AnimatedPopupState();
}

class _AnimatedPopupState extends State<AnimatedPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationSigninController;
  Animation<double>? _animationSignin;

  @override
  void initState() {
    super.initState();
    _animationSigninController = AnimationController(
      vsync: this,
      duration: kAnimationDuration(0.3),
    );
    _animationSignin = CurvedAnimation(
        parent: _animationSigninController!, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    super.dispose();
    _animationSigninController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationSigninController!.forward();
    return ScaleTransition(
      scale: _animationSignin!,
      child: widget.child,
    );
  }
}
