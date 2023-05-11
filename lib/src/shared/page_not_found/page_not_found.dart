import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Colors,
        Column,
        FontWeight,
        Key,
        Scaffold,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        TextAlign,
        TextStyle,
        Widget;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../constants/constants.dart';
import '../../utils/extensions/extensions.dart';

class KPageNotFound extends StatelessWidget {
  const KPageNotFound({
    Key? key,
    required this.error,
  }) : super(key: key);

  final Object error;

  @override
  Widget build(BuildContext context) {
    // printUrlHistory(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: mainMin,
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(
                'assets/svgs/error.svg',
                height: context.width * 0.35,
                width: context.width * 0.35,
              ),
              Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KServerNotRunning extends StatelessWidget {
  const KServerNotRunning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // printUrlHistory(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: mainMin,
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(
                'assets/svgs/server-error.svg',
                height: context.width * 0.35,
                width: context.width * 0.35,
              ),
              const Text(
                'Server is not running! We are working on it. Sorry for the inconvenience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
