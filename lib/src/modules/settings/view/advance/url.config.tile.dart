import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../main.dart';
import '../../../../localization/loalization.dart';
import '../../../../pocketbase/auth.store/helpers.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../model/settings.model.dart';
import '../../provider/settings.provider.dart';

class URLConfigTile extends StatelessWidget {
  const URLConfigTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/url-config.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Url Config',
        ),
      ),
      title: Text(
        t.urlConfig,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const URLConfigPopup(),
      ),
    );
  }
}

class URLConfigPopup extends ConsumerWidget {
  const URLConfigPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void pop() => Navigator.pop(context);
    ref.watch(settingsStreamProvider);
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        titlePadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        actionsPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
        title: Row(
          children: [
            const Expanded(child: Text('URL Config')),
            IconButton(
              icon: const Icon(Icons.close),
              splashRadius: 18.0,
              onPressed: pop,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile.adaptive(
              dense: true,
              title: const Text('Live'),
              value: appSettings.baseUrl.contains('pockethost'),
              onChanged: (live) async {
                appSettings.baseUrl = live ? globalBaseUrl : localBaseUrl;
                await appSettings.save();
              },
            ),
            const SizedBox(height: 8.0),
            SwitchListTile.adaptive(
              dense: true,
              title: const Text('Secure Protocol'),
              value: appSettings.useSecureProtocol,
              onChanged: (secure) async {
                appSettings.useSecureProtocol = secure;
                await appSettings.save();
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: TextEditingController(text: httpProtocol),
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 10.0),
                labelText: 'HTTP Protocol',
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              onChanged: (url) => appSettings.baseUrl = url,
              controller: TextEditingController(text: appSettings.baseUrl),
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 10.0),
                labelText: 'Base URL',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Done'),
            onPressed: () async => await appSettings.save().then((_) => pop()),
          ),
        ],
      ),
    );
  }
}
