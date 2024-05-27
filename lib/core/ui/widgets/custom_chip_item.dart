// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';

class CustomChipItem extends StatelessWidget {
  final String? label;
  final IconData? iconData;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget? widgetChild;
  final VoidCallback? onPressed;

  const CustomChipItem(
      {Key? key,
      this.label,
      this.widgetChild,
      this.iconData,
      required this.backgroundColor,
      required this.foregroundColor,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                height: 28,
                child: widgetChild == null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (iconData != null) ...[
                            Icon(
                              iconData,
                              color: foregroundColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                          if (label != null)
                            Text(
                              label!,
                              style: TextStyle(
                                color: foregroundColor,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Roboto',
                              ),
                            ),
                        ],
                      )
                    : widgetChild),
          ),
        ],
      ),
    );
  }
}

CustomChipItem getOnlineChip() {
  return CustomChipItem(
    label: 'عن بعد/ أونلاين',
    backgroundColor: ColorManager.lightBlue,
    foregroundColor: ColorManager.blue1,
  );
}

CustomChipItem getFaceToFaceChip(String location, String image) {

  return CustomChipItem(
    widgetChild: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            'حضوري وجها لوجه في $location ',
            maxLines: 1,
            style: TextStyle(
              color: ColorManager.darkBlue,
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        SizedBox(width: 4,),
        Container(
            width: 20,
            height: 20,
            child: FittedBox(
              child: CustomImage(
                image: image,
                width: 20,
                height: 20,
                isCircle: false,
              ),
            ))
      ],
    ),
    backgroundColor: ColorManager.gray1.withOpacity(0.4),
    foregroundColor: ColorManager.darkBlue,
  );
}

CustomChipItem getGrayChip({required String text, VoidCallback? onPressed}) {
  return CustomChipItem(
    label: text,
    backgroundColor: ColorManager.gray1.withOpacity(0.4),
    foregroundColor: ColorManager.darkBlue,
    onPressed: onPressed,
  );
}

Widget getLastUpdateChip(String date) {
  return CustomChipItem(
    label: 'آخر تحديث: ${DateFormatter.getFormatedDate(date)}',
    backgroundColor: ColorManager.lightGreen,
    foregroundColor: ColorManager.green1,
    iconData: Icons.calendar_month,
  );
}

Widget getSpecialCourse() {
  return CustomChipItem(
    label: 'دورة مميزة',
    backgroundColor: ColorManager.lightRed,
    foregroundColor: ColorManager.red1,
  );
}

Widget getBlackEmptyChip({required String text, VoidCallback? onPressed}) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        width: 1,
        color: Colors.grey,
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        overflow: TextOverflow.ellipsis,
        fontFamily: 'Roboto',
      ),
    ),
  );
}

Widget getAcceptedChip(){
  return Card(
    elevation: 0.2,
    child: CustomChipItem(
      label: 'تم القبول',
      backgroundColor: ColorManager.lightGreen1,
     foregroundColor: ColorManager.green1,
    ),
  );
}
Widget getRejectedChip(){
  return Card(
     elevation: 0.2,

    child: CustomChipItem(
      label: 'تم الرفض',
      backgroundColor: ColorManager.lightRed,
      foregroundColor: ColorManager.red1,
    ),
  );
}
