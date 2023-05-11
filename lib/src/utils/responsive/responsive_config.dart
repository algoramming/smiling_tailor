import 'package:flutter/material.dart'
    show BuildContext, Key, LayoutBuilder, MediaQuery, StatelessWidget, Widget;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 650 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 650) {
          return desktop;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
