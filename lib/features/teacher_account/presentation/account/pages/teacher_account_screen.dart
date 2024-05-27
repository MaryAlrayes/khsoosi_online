import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/edit_password/presentation/pages/edit_password_screen.dart';
import 'package:khosousi_online/features/location/presentation/pages/location_map_screen.dart';
import 'package:khosousi_online/features/refresh/presentation/cubit/refresh_account_cubit.dart';
import 'package:khosousi_online/features/refresh/presentation/dialog/show_refresh_account_dialog.dart';
import 'package:khosousi_online/features/settings/presentation/screens/settings_screen.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/widgets/custom_account_card.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/charge_screen.dart';
import 'package:khosousi_online/features/teacher_balance/presentation/pages/teacher_balance_screen.dart';
import 'package:khosousi_online/features/teacher_courses/presentation/pages/teacher_courses_screen.dart';
import 'package:khosousi_online/features/teacher_portofolio/presentation/pages/teacher_portofolio_screen.dart';
import 'package:khosousi_online/features/teacher_rates/presentation/pages/teacher_rates_screen.dart';
import 'package:khosousi_online/features/teacher_services/presentation/pages/teacher_services_screen.dart';

import '../widgets/custom_account_list_tile.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

class TeacherAccountScreen extends StatelessWidget {
  const TeacherAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<RefreshAccountCubit>(),
      child: Builder(builder: (context) {
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
                    _personalProfile(context),
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
      }),
    );
  }

  Widget _buildGeneralCard(BuildContext context) {
    return CustomAccountCard(
      isList: true,
      title: 'عام',
      childrenList: [
        CustomAccountListTile(
            label: 'سداد عمولة مستحقة',
            icon: Icon(
              FontAwesomeIcons.coins,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: ChargeScreen());
            }),
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

  Widget _personalProfile(BuildContext context) {
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
        CustomAccountListTile(
            label: 'معاينة الملف الشخصي',
            icon: Icon(
              FontAwesomeIcons.eye,
              size: 18,
            ),
            onPressed: () {}),
        CustomAccountListTile(
            label: 'فيديو التعريف الخاص في',
            icon: Icon(
              FontAwesomeIcons.youtube,
              size: 18,
            ),
            onPressed: () {}),
        CustomAccountListTile(
            label: 'تحديد الموقع الجغرافي',
            icon: Icon(
              FontAwesomeIcons.mapLocation,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: LocationMapScreen());
            }),
        CustomAccountListTile(
            label: 'تحديث الحساب',
            icon: Icon(
              FontAwesomeIcons.arrowsRotate,
              size: 18,
            ),
            onPressed: () {
              BlocProvider.of<RefreshAccountCubit>(context).refreshAccount();
              showRefreshAccountDialog(context);
            }),
      ],
    );
  }

  Widget _buildAccountCard(BuildContext context) {
    return CustomAccountCard(
      isList: true,
      title: 'حسابي',
      childrenList: [
        CustomAccountListTile(
            label: 'تقييماتي',
            icon: Icon(
              FontAwesomeIcons.star,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: TeacherRatesScreen());
            }),
        CustomAccountListTile(
            label: 'دوراتي',
            icon: Icon(
              FontAwesomeIcons.chalkboardUser,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: TeacherCoursesScreen());
            }),
        CustomAccountListTile(
            label: 'خدماتي',
            icon: Icon(
              FontAwesomeIcons.graduationCap,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: TeacherServicesScreen());
            }),
        CustomAccountListTile(
            label: 'شروحاتي',
            icon: Icon(
              FontAwesomeIcons.book,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: TeacherPortofolioScreen());
            }),
        CustomAccountListTile(
            label: 'رصيدي',
            icon: Icon(
              FontAwesomeIcons.wallet,
              size: 18,
            ),
            onPressed: () {
              pushScreen(context: context, screen: TeacherBalanceScreen());
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
