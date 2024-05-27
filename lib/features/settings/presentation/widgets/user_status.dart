import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/features/settings/presentation/widgets/pause_switch.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حالة الظهور',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
        ),
        SizedBox(
          height: 8,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'نشط: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Roboto'
                )),
            TextSpan(
              text: ' تعني ان ملفك ودوراتك وخدماتك تظهر حاليا للطلاب',
              style: TextStyle(
                color: Colors.black54,
                  fontFamily: 'Roboto'
              ),
            ),
          ]),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'متوقف مؤقتا: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            TextSpan(
              text:
                  'تعني ان ملفك ودوراتك وخدماتك مخفية حاليا ولاتظهر للطلاب, بامكانك ايقاف ظهور ملفك بشكل مؤقت في اوقات انشغالك وعدم قدرتك على تقديم خدماتك للطلبة, في هذه الحالة لن تاتيك اي طلبات من الطلاب خلال فترة ايقاف ملفك, وبامكانك اعادة تنشيطه مرة اخرى بأي وقت.',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        PauseSwitch(),
      ],
    );
  }
}
