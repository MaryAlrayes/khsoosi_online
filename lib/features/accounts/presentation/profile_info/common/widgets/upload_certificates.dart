// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import 'package:khosousi_online/core/ui/style/common_styles.dart';

import '../../../../../../core/managers/color_manager.dart';
import '../../../../../../core/utils/helpers/pick_image.dart';

class UploadCertificates extends StatefulWidget {
  final Function onAddImage;
  final Function onRemoveImage;
  const UploadCertificates({
    Key? key,
    required this.onAddImage,
    required this.onRemoveImage,
  }) : super(key: key);

  @override
  State<UploadCertificates> createState() => _UploadCertificatesState();
}

class _UploadCertificatesState extends State<UploadCertificates> {
  List<File> images = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'رفع صور الشهادات الاكاديمية والمهنية:',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 16,
        ),
        _buildUploadCard(context),
        SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              return _buildImageCard(context, index);
            },
            itemCount: images.length,
            separatorBuilder: (context, index) => SizedBox(
              height: 8,
            ),
          ),
        )
      ],
    );
  }

  InkWell _buildUploadCard(BuildContext context) {
    return InkWell(
      onTap: () async {
        ImageSource imageSource = await showPickerImageSheet(context);
        File? pickedImage = await pickImage(context, imageSource);

        setState(() {
          if (pickedImage != null) images.add(pickedImage);
        });
        widget.onAddImage(pickedImage);
      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorManager.orange.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: DashedBorder.fromBorderSide(
            dashLength: 4,
            side: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload, color: Colors.grey),
            SizedBox(
              height: 8,
            ),
            Text(
              'اضغط هنا لتحميل الشهادة',
              style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildImageCard(BuildContext context, int index) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorManager.gray2,
        borderRadius: BorderRadius.circular(8),
        border: DashedBorder.fromBorderSide(
          dashLength: 4,
          side: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Image.file(
              images[index],
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              images[index].path.split('/').last,
              style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
              onPressed: () {
                  widget.onRemoveImage(images[index]);
                setState(() {
                  images.remove(images[index]);
                });
              },
              icon: Icon(Icons.cancel))
        ],
      ),
    );
  }
}
