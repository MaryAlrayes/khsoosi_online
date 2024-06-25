import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/accounts/presentation/login/blocs/authentication_bloc.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/student_conditions.dart';
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
      appBar: getCustomAppBar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              children: [
                _buildNameAndEmail(context),
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
              barPushScreen(context: context, screen: SettingsScreen());
            }),
        CustomAccountListTile(
            label: 'اتفاقية استخدام الموقع',
            icon: Icon(
              FontAwesomeIcons.handshake,
              size: 18,
            ),
            onPressed: () {
                barPushScreen(context: context, screen: StudentConditions());

            }),
        CustomAccountListTile(
            label: 'تغيير كلمة المرور',
            icon: Icon(
              FontAwesomeIcons.key,
              size: 18,
            ),
            onPressed: () {
              barPushScreen(context: context, screen: EditPasswordScreen());
            }),
        CustomAccountListTile(
            label: 'تسجيل الخروج',
            icon: Icon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: 18,
            ),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LogOutUserEvent());
            })
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
              barPushScreen(
                  context: context, screen: StudentStatisticsScreen());
            }),
        CustomAccountListTile(
            label: 'المفضلة',
            icon: Icon(
              Icons.favorite,
              size: 18,
            ),
            onPressed: () {
              barPushScreen(context: context, screen: FavoritesScreen());
            }),
      ],
    );
  }

  Widget _buildNameAndEmail(BuildContext context) {
    return CustomAccountCard(
      child: Row(
        children: [
          CustomImage(
            isCircle: true,
            radius: 25,
            image: context.read<AuthRepo>().getUserInfo()!.image,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.read<AuthRepo>().getUserInfo()!.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  context.read<AuthRepo>().getUserInfo()!.email,
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
