import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/extensions/extensions.dart';
import 'take.image.option.dart';

Future<File?> modalBottomSheetMenu(BuildContext context,
    {bool isCircle = false}) async {
  return showModalBottomSheet(
    elevation: 2.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    context: context,
    builder: (_) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            'Choose an Option',
            style: context.theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text('Capture Image With Camera'),
          onTap: () async => await takeImageOption(context, ImageSource.camera,
                  isCircle: isCircle)
              .then((file) async {
            if (file == null) return;
            Navigator.pop(context, file);
          }),
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Select Image From Gallery'),
          onTap: () async => await takeImageOption(context, ImageSource.gallery,
                  isCircle: isCircle)
              .then((file) async {
            if (file == null) return;
            Navigator.pop(context, file);
          }),
        ),
        ListTile(
          leading: const Icon(Icons.cancel),
          title: const Text('Cancel'),
          onTap: () => Navigator.pop(context, null),
        ),
      ],
    ),
  );
}
