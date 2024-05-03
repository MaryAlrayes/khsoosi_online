// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/ui/widgets/custom_data_table.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_certificates_entity.dart';

class Certificates extends StatelessWidget {
  final List<TeacherCertificatesEntity> certificates;
  const Certificates({
    Key? key,
    required this.certificates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           if (certificates.isNotEmpty)  CustomDataTable(
                columns: ['الشهادة', 'الوصف'],
                rows: certificates.map(
                  (e) {
                    return _buildRow(e);
                  },
                ).toList()),
            if (certificates.isEmpty) ...[
              SizedBox(
                height: 8,
              ),
              Text('لا يوجد شهادات',style: TextStyle(fontSize: 14),textAlign: TextAlign.center,)
            ]
          ],
        ),
      ),
    );
  }

  DataRow _buildRow(TeacherCertificatesEntity e) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          if (e.image.isNotEmpty) ...[
            SizedBox(
              width: 40,
              height: 40,
              child: Image.network(e.image),
            ),
            SizedBox(
              width: 4,
            ),
          ],
          Text(e.name)
        ],
      )),
      DataCell(
        Text(
          e.description,
        ),
      ),
    ]);
  }
}
