import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/features/rates/presentation/pages/rates_section.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

class TabRates extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  TabRates({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatesSection(
      rates: teacherDetailsEntity.reviewEntity,
      mainRate: teacherDetailsEntity.averageRate,
    );
  }
}
