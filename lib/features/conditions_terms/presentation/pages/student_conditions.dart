import 'package:flutter/material.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/main_conditions_screen.dart';

class StudentConditions extends StatelessWidget {
  static const routeName = 'student_conditions';
  const StudentConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return MainConditionsScreen(
      rejectWidget: Column(
        children: [
          Text(
            """عدم موافقتك على شروط الاستخدام تعني بالضرورة عدم رغبتك بالاستفادة من خدمات الموقع فبالتالي لن يظهر ملفك ضمن نتائج البحث بالموقع قبل موافقتك على شروط الاستخدام
""",
            style: TextStyle(color: Colors.red, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            """ان واجهتك اي مشكلة او تود الشكوى بخصوص امر ما نرجو التواصل معنا من خلال ايقونة “الدعم والمساعدة”الموجودة باسفل يمين الشاشة بالتطبيق بعد تسجيل الدخول بالتطبيق,  لحل مشكلتك بشكل مباشر""",
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
      mainWidget: Column(
        children: [
          Text(
            'عدم موافقتك على شروط الاستخدام تعني بالضرورة عدم رغبتك بالاستفادة من خدمات الموقع فبالتالي لن يظهر ملفك ضمن نتائج البحث بالموقع قبل موافقتك على شروط الاستخدام',
            style: TextStyle(color: Colors.red, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            """ لكونك مستخدم فأنك توافق على الالتزام بكل ما يرد بهذه الاتفاقية في حالة التسجيل في الموقع كمدرّس/مركز تدريبي.
يحق لموقع المدرس الخصوصي التعديل على هذه الاتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان عن التحديث في الموقع أو في أي وسيلة آخرى.
بصفتك مدرّس/ مركز تدريبي مسجل في هذا الموقع فإنه بموافقتك على الاستفادة من خدمات الموقع فعليك الالتزام بما يلي :      """,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            """الدقة باحتساب عمولة الموقع ومعرفة مصدر الطالب هي مسؤولية المدرس وبذمته بشكل كامل.
إن عدم التزامك بهذه الشروط يمنح موقع المدرس الخصوصي الحق كاملا بحجب عضويتك ومنعك من الوصول للموقع دون الحاجة لإخطارك بذلك """,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
