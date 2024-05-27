// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:khosousi_online/core/ui/widgets/custom_data_table.dart';
import 'package:khosousi_online/core/ui/widgets/custom_html_widget.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_certificates_entity.dart';

class TabCertificates extends StatelessWidget {
  final List<TeacherCertificatesEntity> certificates;
  const TabCertificates({
    Key? key,
    required this.certificates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (certificates.isNotEmpty) _buildTable(),
            if (certificates.isEmpty) ..._buildEmpty
          ],
        ),
      ),
    );
  }

  List<Widget> get _buildEmpty {
    return [
      SizedBox(
        height: 8,
      ),
      Text(
        'لا يوجد شهادات',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      )
    ];
  }

  CustomDataTable _buildTable() {
    return CustomDataTable(
        columns: ['الشهادة', 'الوصف'],
        rows: certificates.map(
          (e) {
            return _buildRow(e);
          },
        ).toList());
  }

  DataRow _buildRow(TeacherCertificatesEntity e) {
    return DataRow(key: UniqueKey(), cells: [
      DataCell(Row(
        children: [
          if (e.image.isNotEmpty) ...[
            SizedBox(
              width: 40,
              height: 40,
              child: CustomImage(
                image: e.image,
                isCircle: false,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
          Text(
            e.name,
            style: TextStyle(fontSize: 12),
          )
        ],
      )),
      DataCell(Text(
        CustomHtmlParser.parseHtml(e.description),
        style: TextStyle(fontSize: 12),
      )),
    ]);
  }
}
