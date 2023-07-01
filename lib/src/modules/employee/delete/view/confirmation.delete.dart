import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../shared/animations_widget/animated_popup.dart';

class ConfirmDeletePopup extends StatefulWidget {
  const ConfirmDeletePopup(this.onConfirm, {super.key});

  final Future<void> Function()? onConfirm;

  @override
  State<ConfirmDeletePopup> createState() => _ConfirmDeletePopupState();
}

class _ConfirmDeletePopupState extends State<ConfirmDeletePopup> {
  String? text;
  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        scrollable: true,
        title: const Text('Confirm Delete'),
        content: SizedBox(
          width: min(context.width, 400),
          child: Column(
            children: [
              Text(
                'Are you sure you want to delete this employee and all related transactions?',
                style: context.text.titleSmall,
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'To confirm delete, please type ',
                      style: context.text.labelLarge,
                    ),
                    TextSpan(
                      text: '\'DELETE\' ',
                      style: context.text.labelLarge!.copyWith(
                        color: context.theme.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: 'in the box below.',
                      style: context.text.labelLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                onChanged: (v) => setState(() => text = v),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: text != 'DELETE'
                ? null
                : () async => await widget.onConfirm?.call(),
            child: Text(
              'Delete Employee',
              style: TextStyle(
                color:
                    text != 'DELETE' ? Colors.red.withOpacity(0.5) : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
