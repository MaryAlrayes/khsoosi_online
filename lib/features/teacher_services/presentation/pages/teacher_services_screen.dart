import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_data_table.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_round_btn.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/edit_password/presentation/pages/edit_password_screen.dart';
import 'package:khosousi_online/features/settings/presentation/screens/settings_screen.dart';
import 'package:khosousi_online/features/teacher_account/presentation/account/widgets/custom_account_card.dart';

class TeacherServicesScreen extends StatelessWidget {
  const TeacherServicesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'خدماتي',
        ),
      ),
      floatingActionButton: _buildAddService(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDataTable(
                  columns: ['العنوان', 'الحالة', 'خيارات'],
                  rows: [_buildRow(), _buildRow(), _buildRow()],
                ),
                SizedBox(
                  height: 16,
                ),
                _buildServicesNumber()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _buildServicesNumber() => Text('عدد الخدمات: 6');

  DataRow _buildRow() {
    return DataRow(key: UniqueKey(), cells: [
      DataCell(_buildTitle()),
      DataCell(_buildStatus()),
      DataCell(_buildButtons())
    ]);
  }

  Padding _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          getUpdateRoundBtn(onPressed: () {}),
          SizedBox(
            width: 16,
          ),
          getRefreshRoundBtn(onPressed: () {}),
          SizedBox(
            width: 16,
          ),
          getDeleteRoundBtn(onPressed: () {})
        ],
      ),
    );
  }

  Padding _buildStatus() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: getRejectedChip(),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CustomImage(
                image:
                    'https://st2.depositphotos.com/1350793/8224/i/450/depositphotos_82249918-stock-photo-hand-pressing-an-online-course.jpg',
                isCircle: false,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'دبلوم اللغة الصينية من غرفة تجارة ابها بالسعودية',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'لغة صينية',
                style: TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  FloatingActionButton _buildAddService() {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      onPressed: () {},
      label: Text('إضافة خدمة'),
      backgroundColor: ColorManager.green1,
      foregroundColor: Colors.white,
    );
  }
}
