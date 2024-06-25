import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/string_manager.dart';
import 'package:khosousi_online/core/ui/dialogs_widgets/loading_content_dialog.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/cubit/answer_conditions_cubit.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/main_conditions_screen.dart';

class InstituteConditions extends StatelessWidget {
  static const routeName = 'institute_conditions';
  const InstituteConditions({super.key});

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
          Divider(
            height: 8,
          ),
          SizedBox(
            height: 8,
          ), Text(
            """عدم الموافقة على شروط استخدام الموقع يوقف ظهور ملفك ضمن نتائج البحث عن المدرسين بالموقع. """,
           style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          )
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
            """لكونك مستخدم فأنك توافق على الالتزام بكل ما يرد بهذه الاتفاقية في حالة التسجيل في الموقع كمدرّس/مركز تدريبي.
يحق لموقع المدرس الخصوصي التعديل على هذه الاتفاقية في أي وقت وتعتبر ملزمة لجميع الأطراف بعد الإعلان عن التحديث في الموقع أو في أي وسيلة آخرى.
بصفتك مدرّس/ مركز تدريبي مسجل في هذا الموقع فإنه بموافقتك على الاستفادة من خدمات الموقع فعليك الالتزام بما يلي :""",
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
            """استاذنا العزيز, المؤمن إذا وعد يتحرَّى الوفاء بالوعد
-------------------
قَالَ الله تَعَالَى: وَأَوْفُوا بِالْعَهْدِ إِنَّ الْعَهْدَ كَانَ مَسْؤُولًا [الإسراء:34].
وقال تَعَالَى: وَأَوْفُوا بِعَهْدِ اللَّهِ إِذَا عَاهَدْتُمْ [النحل:91].
وقال تَعَالَى: يَا أَيُّهَا الَّذِينَ آمَنُوا أَوْفُوا بِالْعُقُودِ [المائدة:1].
وقال تَعَالَى: يَا أَيُّهَا الَّذِينَ آمَنُوا لِمَ تَقُولُونَ مَا لَا تَفْعَلُونَ ۝ كَبُرَ مَقْتًا عِنْدَ اللَّهِ أَنْ تَقُولُوا مَا لَا تَفْعَلُونَ [الصف:2، 3].

اتعهد واقسم بالله على مايلي:
- عدم الإعلان أو تحميل محتوى أو عناصر غير ملائمة للتصنيفات المتاحة في الموقع. وعليك مراجعة شروط إضافة الدورات والخدمات ضمن صفحة الإضافة الخاصة بكل واحدة منها.
- عدم استخدام أي وسيلة غير شرعية للوصول للإعلانات أو لبيانات المستخدمين الآخرين على الموقع والاستفادة منها بأي شكل من الأشكال أو إعادة نشرها.
- عدم نشر إعلانات أو تعليقات كاذبة أو غير دقيقة أو مضللة أو خادعة أو تشهير.
- عدم جمع معلومات عن مستخدمي الموقع الآخرين لأغراض تجارية أو غيرها.
- عدم الإقدام على أي ما من شأنه إلحاق الضرر بسمعة موقع المدرس الخصوصي, او محاولة ايذاءه سواءا بطريقة تقنية برمجية او غيرها.
- يمنع إنشاء اكثر من عضوية واحدة بالموقع, إنشاؤك لاكثر من عضوية لنفس الشخص سيعرض عضوياتك كلها للحظر النهائي الى الابد مع حظر جميع ال IPs الخاصة بك, اضافة الى حظر جميع اجهزة الحاسب والجوال المرتبطة بعضويتك, الى الابد.
- مع العلم انه في حال وجود اشكالية معينة بعضويتك ولم تستطع اصلاحها فضلا تواصل معنا واطلب المساعدة عبر: شاشة الاتصال بنا""",
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorManager.lightRed,
                border: Border.all(width: 0.5, color: Colors.red)),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'اتعهد واقسم بالله على الالتزام بسداد عمولة موقع المدرس الخصوصي عن اي خدمات تعليمية قد قدمتها وكان الموقع سبباً مباشراً او حتى غير مباشر في تقديمي لهذه الخدمات.',
                  style: TextStyle(
                      color: ColorManager.darkRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
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
                  """عمولة الموقع هي نسبة مئوية من اي ايراد قد حصل عليه المدرس/المركز التدريبي عن طريق الموقع, العمولة هي عن اجمالي التعامل المالي مع الطالب وليس عن اول درس فقط او اول فصل دراسي فقط, الامر متروك بيد المدرس لتحديد النسبة التي يود دفعها ابتداءا من 25% فما فوق, لكن النسبة المئوية تكون على الأقل 25% من اجمالي قيمة التعامل المالي مع الطالب, والمجال مفتوح امام المدرس ليرفع النسبة المئوية التي يود دفعها للموقع بحسب مايراه مناسبا, ابتداءا من 25%.(رفع النسبة المئوية يؤدي بالنتيجة الى تمييز ملف المدرس بالموقع فيحصل على طلبات ودروس اكثر)""",
                  style: TextStyle(color: ColorManager.darkRed, fontSize: 12),
                ),
              ],
            ),
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
            """طريقة دفع العمولة: يتم دفع العمولة بشكل شهري, تواصل معنا من خلال نظام خدمة العملاء لتزويدك بطرق الدفع.

مثال: ان كان المبلغ المحصّل بسبب الموقع بشكل مباشر او غير مباشر هو 10 ريال, عمولة الموقع تكون 2.5 ريال بحد ادنى وقابلة للزيادة عند رغبة المدرس بذلك.
مثال اخر: ان كان المبلغ 500 ريال, عمولة الموقع تكون 125 ريال بحد ادنى وقابلة للزيادة عند رغبة المدرس بذلك.
مثال اخر: اذا كان المبلغ 1000 دولار, عمولة الموقع تكون 250 دولار بحد ادنى وقابلة للزيادة عند رغبة المدرس بذلك.""",
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
إن عدم التزامك بهذه الشروط يمنح موقع المدرس الخصوصي الحق كاملا بحجب عضويتك ومنعك من الوصول للموقع دون الحاجة لإخطارك بذلك.""",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
