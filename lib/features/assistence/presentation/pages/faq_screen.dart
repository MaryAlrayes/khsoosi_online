import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/widgets/custom_expansion_tile.dart';

class FAQScreen extends StatelessWidget {
  static const routeName = 'faq_screen';
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('الأسئلة الأكثر شيوعا'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(
            height: 4,
          ),
          itemBuilder: (context, index) => CustomExpansionTile(
            title: 'كيفية الشكوى على مدرس',
            children: [
              Text(
                """قمت بالتعامل مع مدرس بالموقع وحصلت مشكلة بيننا,

ماالعمل؟

الاجابة: بامكانك انشاء شكوى ضد المدرس, من خلال الضغط على زر "تبليغ" الموجود بأعلى ملف المدرس نفسه.

مع العلم انه بكل الاحوال اي تعامل بين الطرفين هو على مسؤوليتكم الشخصية ولايتحمل الموقع اي مسؤولية, لكن تبليغك عن مدرس ما يمنحنا الفرصة لاغلاق حسابه لحماية المستخدمين الاخرين منه.""",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
