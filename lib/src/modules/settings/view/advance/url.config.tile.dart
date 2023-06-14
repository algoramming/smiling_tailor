import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/url.config.provider.dart';

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
    ref.watch(urlConfigProvider);
    final notifier = ref.watch(urlConfigProvider.notifier);
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
            ToggleSwitch(
              initialLabelIndex: notifier.currUrlIndex,
              totalSwitches: notifier.urls.length,
              labels: notifier.urlHeaders,
              onToggle: notifier.toggleUrl,
            ),
            const SizedBox(height: 10.0),
            SwitchListTile.adaptive(
              dense: true,
              title: const Text('Secure Protocol'),
              value: notifier.currSettings.useSecureProtocol,
              onChanged: notifier.toggleSecureProtocol,
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: TextEditingController(
                  text: notifier.currSettings.useSecureProtocol
                      ? 'https'
                      : 'http'),
              enabled: false,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 10.0),
                labelText: 'HTTP Protocol',
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: notifier.urlCntrlr,
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 10.0),
                labelText: 'Base URL',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Done',
                style: TextStyle(color: context.theme.primaryColor)),
            onPressed: () async => await notifier.submit().then((_) => pop()),
          ),
        ],
      ),
    );
  }
}
