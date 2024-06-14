// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/student_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/teacher_screen.dart';

class HomepageScreen extends StatelessWidget {
  final UserType userType;
  const HomepageScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (userType) {
      case UserType.student:
        return StudentScreen();
      case UserType.teacher:
        return TeacherScreen();
      case UserType.institute:
        return TeacherScreen();
    }
  }
}
