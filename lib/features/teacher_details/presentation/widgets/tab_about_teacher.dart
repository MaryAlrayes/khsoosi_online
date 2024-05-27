import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_universities_entity.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';


class TabAboutTeacher extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  const TabAboutTeacher({
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
          _buildReadMoreText(),
          SizedBox(
            height: 16,
          ),
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

  Widget _buildReadMoreText() {
    return CustomReadText(
      text: CustomHtmlParser.parseHtml(
        teacherDetailsEntity.teacherDescription,
      ),
      trimLines: 4,
    );


  }

  Widget _buildUniversities() {
    List<TeacherUniversitiesEntity> _data = teacherDetailsEntity.universities;
    return _data.isEmpty
        ? Text('لا يوجد جامعات')
        : Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _data
                .map(
                  (e) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: getBlackEmptyChip(
                            text: e.universityNameAr +
                                ' | ' +
                                e.universityNameEn),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
  }
}
