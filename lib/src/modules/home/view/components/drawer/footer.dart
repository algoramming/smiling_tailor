import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/extensions/extensions.dart';

class KDrawerFooter extends StatelessWidget {
  const KDrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Developed by ',
                style: context.text.labelSmall,
              ),
              InkWell(
                onTap: () async {
                  final url = Uri.parse('https://algoramming.github.io/');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Text(
                  'Algoramming',
                  style: context.text.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.primaryColor,
                  ),
                ),
              ),
              // const Text(
              //   ' in 💙 with ',
              //   style: TextStyle(
              //     fontSize: 13,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.black,
              //   ),
              // ),
              // InkWell(
              //   onTap: () async =>
              //       await canLaunchUrl(Uri.parse('https://flutter.dev/'))
              //           ? await launchUrl(Uri.parse('https://flutter.dev/'))
              //           : throw 'Could not launch the url',
              //   child: Text(
              //     'Flutter',
              //     style: TextStyle(
              //       fontSize: 13,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.blue[700],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
