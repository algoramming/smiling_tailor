import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/constants.dart';
import '../../../../localization/loalization.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/error_widget/error_widget.dart';
import '../../../../shared/k_list_tile.dart/k_list_tile.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/fonts.provider.dart';

class FontTile extends StatelessWidget {
  const FontTile({super.key});

  @override
  Widget build(BuildContext context) {
    return KListTile(
      leading: AnimatedWidgetShower(
        size: 30.0,
        child: SvgPicture.asset(
          'assets/svgs/font.svg',
          colorFilter: context.theme.primaryColor.toColorFilter,
          semanticsLabel: 'Font',
        ),
      ),
      title: Text(
        t.font,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: OutlinedButton.icon(
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const FontChangerPopup(),
        ),
        label: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15.0,
          color: context.theme.primaryColor,
        ),
        icon: Consumer(
          builder: (_, ref, __) => Text(
            ref.watch(fontProvider).split('_').first,
            style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 13.0),
          ),
        ),
      ),
    );
  }
}

class FontChangerPopup extends ConsumerWidget {
  const FontChangerPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedPopup(
      child: AlertDialog(
        title: Row(
          children: [
            const Text('Select Font'),
            const Spacer(),
            const SizedBox(width: 10.0),
            InkWell(
              customBorder: roundedRectangleBorder30,
              child: const Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        content: SizedBox(
          height: context.height * 0.8,
          width: min(context.width * 0.8, 400),
          child: ref.watch(allFontStylesProvider).when(
                loading: () => const CircularProgressIndicator(),
                error: (err, _) => KErrorWidget(error: err),
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      onTap: () async => await ref
                          .read(fontProvider.notifier)
                          .changeFont(
                              (data[index]['font'] as TextStyle).fontFamily!)
                          .then((_) => Navigator.of(context).pop()),
                      leading: Radio<String?>(
                        value: (data[index]['font'] as TextStyle).fontFamily,
                        groupValue: ref.watch(fontProvider),
                        onChanged: (v) async => await ref
                            .read(fontProvider.notifier)
                            .changeFont(v!)
                            .then((_) => Navigator.of(context).pop()),
                      ),
                      title: Text(
                        data[index]['name'].toString(),
                        style: (data[index]['font'] as TextStyle).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                      isThreeLine: false,
                      subtitle: Text(
                        'A quick brown fox jumps over the lazy dog',
                        style: (data[index]['font'] as TextStyle).copyWith(
                          fontSize: 13.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
        ),
      ),
    );
  }
}
