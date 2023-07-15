import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../config/constants.dart';
import '../../config/get.platform.dart';
import '../../modules/settings/view/advance/url.config.tile.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';
import '../gradient/gradient.widget.dart';
import '../show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../show_toast/awsome.snackbar/show.awesome.snackbar.dart';

class KPageNotFound extends StatelessWidget {
  const KPageNotFound({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
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
  const KServerNotRunning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
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
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(150, 42)),
                  ),
                  onPressed: () {
                    if (pt.isNotWeb) {
                      exit(0);
                    } else {
                      showAwesomeSnackbar(
                        context,
                        'Message',
                        'Please close the browser tab and visit again.',
                        MessageType.help,
                      );
                    }
                  },
                  label: const Text('Exit'),
                  icon: const Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.settings, size: 20.0),
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const URLConfigPopup(),
        ),
      ),
    );
  }
}

class KDataNotFound extends StatelessWidget {
  const KDataNotFound({super.key, this.msg});

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: mainMin,
            mainAxisAlignment: mainCenter,
            children: [
              SvgPicture.asset(
                'assets/svgs/no-data.svg',
                height: context.width * 0.15,
                width: context.width * 0.15,
              ),
              Text(
                msg ?? 'No data found!',
                textAlign: TextAlign.center,
                style: context.text.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccesDeniedPage extends StatelessWidget {
  const AccesDeniedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: mainMin,
            mainAxisAlignment: mainCenter,
            children: [
              GradientWidget(
                child: SvgPicture.asset(
                  'assets/svgs/access-denied.svg',
                  height: context.width * 0.15,
                  width: context.width * 0.15,
                  // colorFilter: context.theme.primaryColor.toColorFilter,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'You are not authorized to access this page!\nIf you think this is a mistake, please contact your administrator.',
                textAlign: TextAlign.center,
                style: context.text.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
