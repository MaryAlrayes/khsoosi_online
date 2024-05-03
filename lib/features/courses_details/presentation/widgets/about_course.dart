import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';

class AboutCourse extends StatelessWidget {
  const AboutCourse({super.key});
final String _text ="""
هذه الدورة تضم دروس في برامج الاوفيس(وورد, اكسل, بوربوينت, اكسس) بالاضافة الى دروس في نظام التشغيل ويندوز ودروس في كيفية التعامل مع الانترنت والبريد الالكتروني, الدورة مناسبة لجميع الاعمار ولجميع الخلفيات العلمية.

1.ms word

2.ms excel

3.ms powerpoint

4.ms access

5.microsoft windows

6.internet

7.email



مدة الدورة شهرين,

لاي تفاصيل اخرى الرجاء التواصل معي من خلال ملفي على موقع المدرس الخصوصي
""";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.r),
      child: CustomReadText(text: _text, trimLines: 3),
    );
  }
}
