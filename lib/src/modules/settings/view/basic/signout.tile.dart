import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../authentication/api/authentication.api.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            'assets/svgs/signout.svg',
            colorFilter: context.theme.primaryColor.toColorFilter,
            semanticsLabel: 'Signout',
          ),
        ),
      ),
      title: Text(
        t.signout,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const SignoutPopup(),
      ),
    );
  }
}

class SignoutPopup extends StatelessWidget {
  const SignoutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Signout'),
        content: const Text(
            'Are you sure you want to signout? You will be redirected to the login page'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async =>  await pktbsSignout(context),
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
