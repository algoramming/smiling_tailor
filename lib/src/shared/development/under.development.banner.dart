import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/extensions/extensions.dart';
import '../clipboard_data/clipboard_data.dart';

class UnderDevelopmentBanner extends StatelessWidget {
  const UnderDevelopmentBanner({
    super.key,
    this.onPressed,
    this.height = 45.0,
  });

  final double height;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.primaryColor, width: 1.0),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
        ),
        color: context.theme.primaryColor.withOpacity(0.1),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text:
                  'This is a demo version of Smiling Tailor web application. Don\'t use any real information.\n',
              style: context.text.labelMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: 'To login, use Email: ',
              style: context.text.labelMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: 'test@algoramming.com ',
              style: context.text.labelMedium,
            ),
            WidgetSpan(
              child: InkWell(
                onTap: () async => await copyToClipboard(
                  context,
                  'test@algoramming.com',
                  showToast: false,
                ),
                child: const Icon(
                  Icons.copy,
                  size: 14.0,
                ),
              ),
            ),
            TextSpan(
              text: 'and Password: ',
              style: context.text.labelMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: '12345678 ',
              style: context.text.labelMedium,
            ),
            WidgetSpan(
              child: InkWell(
                onTap: () async => await copyToClipboard(
                  context,
                  '12345678',
                  showToast: false,
                ),
                child: const Icon(
                  Icons.copy,
                  size: 14.0,
                ),
              ),
            ),
            TextSpan(
              text: '\nFor more information, click here ',
              style: context.text.labelMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            WidgetSpan(
              child: InkWell(
                onTap: () async {
                  final url = Uri.parse('https://www.algoramming.com/');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: const Icon(
                  Icons.open_in_new,
                  size: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
