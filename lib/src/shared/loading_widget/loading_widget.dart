import 'dart:math';

import 'package:flutter/material.dart';

import '../../config/constants.dart';
import '../../utils/extensions/extensions.dart';
import '../gradient/gradient.text.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.text,
    this.heightWidth,
    this.showText = true,
    this.withScaffold = true,
  });

  final String? text;
  final bool showText;
  final bool withScaffold;
  final double? heightWidth;

  @override
  Widget build(BuildContext context) => withScaffold
      ? Scaffold(
          body: MainLoadingWidget(
              showText: showText, heightWidth: heightWidth, text: text))
      : MainLoadingWidget(
          showText: showText, heightWidth: heightWidth, text: text);
}

class MainLoadingWidget extends StatefulWidget {
  const MainLoadingWidget({
    super.key,
    this.text,
    required this.showText,
    required this.heightWidth,
  });

  final String? text;
  final bool showText;
  final double? heightWidth;

  @override
  State<MainLoadingWidget> createState() => _MainLoadingWidgetState();
}

class _MainLoadingWidgetState extends State<MainLoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    //
    animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
    //
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pd = (widget.heightWidth ?? max(context.width * 0.045, 60)) * 0.2;
    return Center(
      child: Column(
        mainAxisSize: mainMin,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: pd),
                child: AnimatedBuilder(
                  animation: animation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/icons/loading-back-part.png',
                      height:
                          widget.heightWidth ?? max(context.width * 0.045, 60),
                      width:
                          widget.heightWidth ?? max(context.width * 0.045, 60),
                    ),
                  ),
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: animation.value,
                      child: child,
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right:
                        (widget.heightWidth ?? max(context.width * 0.045, 60)) *
                            0.55),
                width: (widget.heightWidth ?? max(context.width * 0.045, 60)) *
                    0.55,
                height: (widget.heightWidth ?? max(context.width * 0.045, 60)) *
                    0.55,
                color: context.theme.scaffoldBackgroundColor,
              ),
              Padding(
                padding: EdgeInsets.only(right: pd),
                child: Image.asset(
                  'assets/icons/loading-front-part.png',
                  height: widget.heightWidth ?? max(context.width * 0.04, 55),
                  width: widget.heightWidth ?? max(context.width * 0.04, 55),
                ),
              ),
            ],
          ),
          if (widget.showText) SizedBox(height: max(context.width * 0.005, 7)),
          if (widget.showText)
            GradientText(
              widget.text ?? 'Loading...',
              style: TextStyle(
                fontSize: max(context.width * 0.011, 13),
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}
