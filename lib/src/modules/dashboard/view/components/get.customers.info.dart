import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_widget_shower.dart';
import '../../../../shared/clipboard_data/clipboard_data.dart';
import '../../../../shared/gradient/gradient.button.dart';
import '../../../../shared/radio_button/k_radio_button.dart';
import '../../../../shared/textfield.suffix.widget/suffix.widget.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../provider/get.customers.info.provider.dart';

class GetCustomersInfo extends ConsumerWidget {
  const GetCustomersInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(getCustomersProvider);
    final notifier = ref.watch(getCustomersProvider.notifier);
    return Column(
      mainAxisSize: mainMin,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: mainMin,
              children: [
                Text(
                  'Get all customers phone numbers or email addresses just in one click',
                  style: context.text.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 7.0),
                Row(
                  mainAxisAlignment: mainSpaceEvenly,
                  children: [
                    KRadioButton(
                      value: 0,
                      label: 'Phone Number',
                      groupValue: notifier.radioOption,
                      onTap: notifier.changeRadioOption,
                    ),
                    KRadioButton(
                      value: 1,
                      label: 'Email Address',
                      groupValue: notifier.radioOption,
                      onTap: notifier.changeRadioOption,
                    ),
                  ],
                ),
                const SizedBox(height: 7.0),
                TextFormField(
                  controller: notifier.joinController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (_) => notifier.refresh(),
                  decoration: InputDecoration(
                    labelText: 'Join',
                    hintText: 'Add delimar to join all items',
                    prefixIcon: ClearPrefixIcon(() {
                      notifier.joinController.clear();
                      notifier.refresh();
                    }),
                    suffixIcon: AnimatedWidgetShower(
                      size: 28.0,
                      child: InkWell(
                        onTap: () {
                          notifier.joinController.text = ',\n';
                          notifier.refresh();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                          child: Center(
                            child: Text(
                              ',↵',
                              style: context.text.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                SizedBox(
                  height: 45.0,
                  child: Row(
                    crossAxisAlignment: crossStart,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: notifier.preffixController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onChanged: (_) => notifier.refresh(),
                          decoration: const InputDecoration(
                            labelText: 'Prefix',
                            hintText: 'Add Prefix',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: borderRadius12,
                            border:
                                Border.all(color: context.theme.primaryColor),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              notifier.content,
                              style: context.text.labelMedium,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: notifier.suffixController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onChanged: (_) => notifier.refresh(),
                          decoration: const InputDecoration(
                            labelText: 'Suffix',
                            hintText: 'Add Suffix',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: mainSpaceEvenly,
                  children: [
                    // GradientButton(
                    //   'Message',
                    //   onTap: () async {
                    //     final uri =
                    //         Uri.parse('sms:${notifier.content}?body=' '');
                    //     if (!await launchUrl(uri)) {
                    //       throw Exception('Could not launch $uri');
                    //     }
                    //   },
                    //   minSize: const Size(70.0, 40.0),
                    // ),
                    GradientButton('Copy to Clipboard', onTap: () async {
                      await copyToClipboard(context, notifier.content);
                    }),
                    if (notifier.radioOption == 0)
                      GradientButton(
                        'Send Message',
                        onTap: () async {
                          final uri =
                              Uri.parse('sms:${notifier.content}?body=' '');
                          if (!await launchUrl(uri)) {
                            throw Exception('Could not launch $uri');
                          }
                        },
                      ),
                    if (notifier.radioOption == 1)
                      GradientButton(
                        'Send Email',
                        onTap: () async {
                          final uri = Uri.parse('mailto:${notifier.content}');
                          if (!await launchUrl(uri)) {
                            throw Exception('Could not launch $uri');
                          }
                        },
                      ),
                    // GradientButton(
                    //   'Email',
                    //   onTap: () async {
                    //     final uri = Uri.parse('mailto:${notifier.content}');
                    //     if (!await launchUrl(uri)) {
                    //       throw Exception('Could not launch $uri');
                    //     }
                    //   },
                    //   minSize: const Size(70.0, 40.0),
                    // ),
                  ],
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
