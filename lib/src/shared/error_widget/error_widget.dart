import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/constants.dart';

class KErrorWidget extends StatelessWidget {
  const KErrorWidget({
    super.key,
    required this.error,
    this.withScaffold = true,
  });

  final bool withScaffold;
  final Object error;

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(body: MainErrorWidget(error: error))
        : MainErrorWidget(error: error);
  }
}

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: mainMin,
          mainAxisAlignment: mainCenter,
          children: [
            SvgPicture.asset(
              'assets/svgs/error.svg',
              height: size.width * 0.35,
              width: size.width * 0.35,
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
    );
  }
}
