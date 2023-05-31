import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../../shared/animations_widget/animated_popup.dart';

class AddOrderPopup extends StatelessWidget {
  const AddOrderPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Title - Add Order'),
        content: const Text(
            'This is a demo alert dialog. Would you like to approve of this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Confirm',
                style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }
}
