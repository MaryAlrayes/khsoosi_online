import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/edit_password/presentation/pages/edit_password_screen.dart';
import 'package:khosousi_online/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:khosousi_online/features/settings/presentation/screens/settings_screen.dart';
import 'package:khosousi_online/features/statistics/presentation/pages/student_statistics_screen.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/widgets/custom_account_card.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/widgets/custom_account_list_tile.dart';

class StudentAccount extends StatelessWidget {
  const StudentAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              children: [
                _buildNameAndEmail(),
                SizedBox(
                  height: 16,
                ),
                _buildAccountCard(context),
                SizedBox(
                  height: 16,
                ),
                _personalProfile(),
                SizedBox(
                  height: 16,
                ),
                _buildGeneralCard(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralCard(BuildContext context) {
    return CustomAccountCard(
      isList: true,
      title: 'عام',
      childrenList: [
        CustomAccountListTile(
            label: 'الإعدادات',
            icon: Icon(
              FontAwesomeIcons.gear,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: SettingsScreen());
            }),
        CustomAccountListTile(
            label: 'اتفاقية استخدام الموقع',
            icon: Icon(
              FontAwesomeIcons.handshake,
              size: 18,
            ),
            onPressed: () {}),
        CustomAccountListTile(
            label: 'تغيير كلمة المرور',
            icon: Icon(
              FontAwesomeIcons.key,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: EditPasswordScreen());
            }),
        CustomAccountListTile(
            label: 'تسجيل الخروج',
            icon: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 18,
            ),
            onPressed: () {})
      ],
    );
  }

  Widget _personalProfile() {
    return CustomAccountCard(
      isList: true,
      title: 'الملف الشخصي',
      childrenList: [
        CustomAccountListTile(
            label: 'تعديل الملف الشخصي',
            icon: Icon(
              FontAwesomeIcons.penToSquare,
              size: 18,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    return CustomAccountCard(
      isList: true,
      title: 'حسابي',
      childrenList: [
        CustomAccountListTile(
            label: 'احصائيات',
            icon: Icon(
              Icons.bar_chart,
              size: 18,
            ),
            onPressed: () {
                pushScreen(context: context, screen: StudentStatisticsScreen());

            }),
        CustomAccountListTile(
            label: 'المفضلة',
            icon: Icon(
              Icons.favorite,
              size: 18,
            ),
            onPressed: () {
                pushScreen(context: context, screen: FavoritesScreen());

            }),
      ],
    );
  }

  Widget _buildNameAndEmail() {
    return CustomAccountCard(
      child: Row(
        children: [
          CustomImage(
            isCircle: true,
            radius: 25,
            image:
                'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww',
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'عمرو عويس',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'example@example.com',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
