// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/helpers/pick_image.dart';

class ProfileImage extends StatefulWidget {
  final Function onChanged;
  const ProfileImage({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorManager.gray3,
            ),
            width: 100,
            height: 100,
            child: image != null
                ? CircleAvatar(
                    backgroundImage: FileImage(image!),
                  )
                : Container(),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
                'الصورة الشخصية تعطي الانطباع القوي لشخصيتك، لذلك تأكد من وضوحها، وأن تكون متساوية الأبعاد بشكل مربع حتى لا تتسوه الصورة، ولا تقم بوضع صورة شخص أخر، (الحجم الأاقصى المسموح للصورة هو 3MB)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12)),
          ),
          SizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: () async {

             ImageSource imageSource = await showPickerImageSheet(context);
              File? pickedImage = await pickImage(context, imageSource);
              setState(() {
                image = pickedImage;
              });
              widget.onChanged(image);
            },
            label: 'اختيار صورة شخصية',
            icon: Icon(Icons.file_upload),
          )
        ],
      ),
    );
  }
}
