import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';

class AboutInstructor extends StatelessWidget {
  const AboutInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(constraints),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Container(
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Text(
                                'mr.geek',
                                style: kBlackBoldTextStyle,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Flexible(
                              child: Text(
                                'computer-teacher-in-riyadh',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            CustomChipItem(
                              label: 'تواصل مع المدرب',
                              backgroundColor: ColorManager.green1,
                              foregroundColor: Colors.white,
                              iconData: Icons.phone,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              _buildRow(
                  text: '8 دورات',
                  icon: Icon(
                    FontAwesomeIcons.noteSticky,
                    size: 16,
                    color: Color(0xffD6293E),
                  ),
                  backgroundColor: Color(0xffFBE9EB)),
              SizedBox(
                height: 8.h,
              ),
              _buildRow(
                  text: 'تدريس عن بعد / تدريس حضوري وجها لوجه',
                  icon: Icon(
                    FontAwesomeIcons.chalkboard,
                    size: 16,
                    color: Color(0xffFD7E14),
                  ),
                  backgroundColor: Color(0xffFFF2E7)),
              SizedBox(
                height: 8.h,
              ),
              _buildRow(
                  text: 'متوسط التقييمات 5/5',
                  icon: Icon(
                    FontAwesomeIcons.solidStar,
                    size: 16,
                    color: Color(0xffF7C32E),
                  ),
                  backgroundColor: Color(0xffFEF6E0)),
              SizedBox(
                height: 16.h,
              ),
              _buildInstructorDetails()
            ],
          ),
        ),
      ),
    );
  }

  Row _buildRow(
      {required String text,
      required Icon icon,
      required Color backgroundColor}) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: backgroundColor, child: icon,radius: 28,),
        SizedBox(
          width: 16,
        ),
        Flexible(
            child: Text(
          text,
          style: TextStyle(fontSize: 12),
        )),
      ],
    );
  }

  Widget _buildInstructorDetails() {
    String _text = """
مدرس حاسب آلي مهندس برمجيات اختصاصي في جميع مواد الحاسب الالي عموما ومواد البرمجة وتحليل النظم خصوصا, تحليل وتصميم نظم, برمجة جافا ,php ,c#.net, خوارزميات, ذكاء صنعي, شبكات,تصميم جرافيك, برامج اوفيس وورد واكسل وبوربوينت

---------

اذا انت طالب جامعي او موظف بمجال IT وبحاجة شخص خبير يساعدك فإن شاء الله انا انسب شخص ممكن يساعدك. خبرة 12 سنة بمجال تدريب هندسة البرمجيات والخوارزميات وتحليل البيانات,

co-founder ومستشار تقني لعدة مشاريع ستارت اب بالعالم العربي

لو انت طالب بمجال علوم الحاسب ممكن اشرح لك اي مادة بتصعب عليك بدراستك, برمجة1, برمجة2, خوارزميات وبنى معطيات, شبكات, هندسة برمجيات وتحليل نظم, قواعد بيانات, او اي مادة جامعية لطلاب الحاسب.

برامج المايكروسوفت اوفيس وخصوووصا اكسل, عندي خبرة كبيرة باكسل وتحليل البيانات باكسل مع خبرة عملية بالمجال ومع شركات كبيرة ومعروفة.

حتى لو كنت ريادي اعمال وعندك فكرة مشروع ممكن ساعدك وقدم لك الاستشارات اللازمة من الالف الى الياء و من باب الخبرة بمساعدة العديد من اصحاب المشاريع الريادية بالعالم العربي.

وهالموضوع تحديدا هو شغف عندي قبل مايكون مادي.

انا جاهز لمساعدتك بأي وقت اونلاين او حضوري وجها لوجه بالرياض, لاتتردد وتواصل معي من خلال ملفي على منصة خصوصي اونلاين.

بكالوريوس هندسة برمجيات متقدمة, درّبت آلاف الطلاب على مدى السنوات الماضية.
""";
    return CustomReadText(text: _text, trimLines: 3);
  }

  Widget _buildImage(BoxConstraints constraints) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CustomImage(
        width: constraints.minWidth / 3,
        image:
            'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww',
      ),
    );
  }
}
