// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_universities_entity.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

class AboutTeacher extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  const AboutTeacher({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          // _buildReadMoreText(),
          // SizedBox(
          //   height: 16,
          // ),
          _buildUniversitiesLabel(),
          SizedBox(
            height: 16,
          ),
          _buildUniversities()
        ],
      ),
    );
  }

  Row _buildUniversitiesLabel() {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.buildingColumns,
          size: 16,
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            'الجامعات التي يدرس لها',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildReadMoreText() {

  // return
  //   HtmlWidget(
  //     teacherDetailsEntity.teacherDescription,
  //     textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color:Colors.black45),
  //   );
  // }

  Widget _buildUniversities() {
    List<TeacherUniversitiesEntity> _data = teacherDetailsEntity.universities;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _data
          .map(
            (e) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: getBlackEmptyChip(
                      text: e.universityNameAr + ' | ' + e.universityNameEn),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
