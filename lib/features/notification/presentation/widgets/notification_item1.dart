// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_html_widget.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

import '../../../../core/ui/widgets/custom_read_text.dart';
import '../../../../core/utils/helpers/date_formatter.dart';
import '../../../../core/utils/helpers/html_parser.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationItem1 extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const NotificationItem1({
    Key? key,
    required this.notificationEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notificationEntity.isRead
          ? Colors.white
          : ColorManager.orange.withOpacity(0.2),
      padding: const EdgeInsets.all(16),
      child: Stack(alignment: Alignment.centerRight, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    notificationEntity.type ,
                    textAlign: TextAlign.right,

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  // color: Colors.blue,
                  child: Text(
                    DateFormatter.getFormatedDate(
                        notificationEntity.date.toString()),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            CustomReadMoreText(
              text: CustomHtmlParser.parseHtml(notificationEntity.text),
              trimLines: 2,
              textStyle: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),

      ]),
    );
  }
}
