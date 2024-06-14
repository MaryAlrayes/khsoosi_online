import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khosousi_online/core/utils/helpers/toast_utils.dart';

Future<File?> pickImage(BuildContext context, ImageSource source) async {
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;
    final imageTemp = File(image.path);
    return imageTemp;
  } on Exception {
    ToastUtils.showErrorToastMessage(
      'حدث خطأ ما، حاول مرة أخرى',
    );
  }
  return null;
}

Future showPickerImageSheet(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
                leading: const Icon(Icons.camera_alt_rounded),
                title: Text('كاميرا'),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                leading: const Icon(Icons.image),
                title: Text('المعرض'),
              ),
            ],
          ),
        ],
      );
    },
  );
}
