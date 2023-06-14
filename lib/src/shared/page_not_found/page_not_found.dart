import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../config/constants.dart';
import '../../config/get.platform.dart';
import '../../modules/settings/view/advance/url.config.tile.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/themes/themes.dart';
import '../show_toast/awesome_snackbar.dart';
import '../show_toast/show_toast.dart';

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
