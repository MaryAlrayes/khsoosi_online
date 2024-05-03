import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

class NotificationItem1 extends StatelessWidget {
  const NotificationItem1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Stack(alignment: Alignment.centerRight, children: [
        Row(
          children: [
            CustomImage(
              image:
                  'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww',
              radius: 24,
              isCircle: true,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'عنوان الاشعار',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'تفاصيل تفاصيل تفاصيل تفاصيل تفاصيل تفاصيل تفاصيل تفاصيل تفاصيل تفاصيل',
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12, color: ColorManager.gray4),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          top: 2,
          child: Container(
            // color: Colors.blue,
            child: Text(
              DateFormat('dd-MM-yyyy ').format(DateTime.now()).toString(),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
