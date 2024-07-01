// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/institute_conditions.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/student_conditions.dart';
import 'package:khosousi_online/features/conditions_terms/presentation/pages/teacher_conditions.dart';
import 'package:khosousi_online/features/homepage/presentation/screens/student_screen.dart';

class ConditionsScreen extends StatelessWidget {
  static const routeName = 'conditions_screen';
  final UserType userType;
  const ConditionsScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return switch (userType) {
      UserType.student => StudentConditions(),
      UserType.teacher => TeacherConditions(),
      UserType.institute => InstituteConditions(),
    };
  }
}
