import 'package:flutter/material.dart';

import '../../../../shared/animations_widget/animated_popup.dart';

class AddEmployeePopup extends StatelessWidget {
  const AddEmployeePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Title - Add Employee'),
        content: const Text(
            'This is a demo alert dialog. Would you like to approve of this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Confirm', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
