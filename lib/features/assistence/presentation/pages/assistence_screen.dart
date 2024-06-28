import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/accounts/presentation/login/widgets/social_media.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/faq_screen.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/personal_assistence.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/social_media_screen.dart';

import '../../../../core/managers/color_manager.dart';

class AssistenceScreen extends StatelessWidget {
  static const routeName = 'assistence_screen';
  const AssistenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context:context),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0).copyWith(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: constraints.maxHeight / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssetsManager.operator,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          colorFilter: ColorFilter.mode(
                            ColorManager.orange,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text('أهلا بك، كيف\n يمكننا مساعدتك؟',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      _buildCard(
                        icon:
                            Icon(Icons.headset_mic, color: ColorManager.black),
                        title: 'المساعد الشخصي',
                        onPressed: () {
                          barPushScreen(
                            context: context,
                            screen: PersonalAssistenceScreen(),
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      _buildCard(
                          icon: Icon(Icons.contact_support_sharp,
                              color: ColorManager.black),
                          title: 'الأسئلة الأكثر شيوعا',
                          onPressed: () {
                            barPushScreen(
                              context: context,
                              screen: FAQScreen(),
                            );
                          }),
                      // SizedBox(height: 8),
                      // _buildCard(
                      //     icon: Icon(Icons.call, color: ColorManager.black),
                      //     title: 'تواصل معنا',
                      //     onPressed: () {
                      //       barPushScreen(
                      //         context: context,
                      //         screen: ContactUsScreen(),
                      //       );
                      //     }),
                      SizedBox(height: 8),
                      _buildCard(
                          icon: Icon(Icons.message, color: ColorManager.black),
                          title: 'مواقع التواصل الاجتماعي',
                          onPressed: () {
                            barPushScreen(
                              context: context,
                              screen: SocialMediaScreen(),
                            );
                          }),
                      SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      {required Icon icon,
      required String title,
      required VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: Card(
        elevation: 1,
        color: Colors.transparent,
        margin: EdgeInsets.all(0),
        child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Material(
              color: Colors.transparent,
              shadowColor: Colors.black,
              child: InkWell(
                splashColor: Colors.black12,
                onTap: () {},
                child: GestureDetector(
                  onTap: () {
                    onPressed();
                  },
                  child: ListTile(
                    leading: icon,
                    title: Text(title, style: TextStyle(fontSize: 12)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
