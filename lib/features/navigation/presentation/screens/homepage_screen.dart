// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/student_screen.dart';
import 'package:khosousi_online/features/navigation/presentation/screens/teacher_screen.dart';

import '../../../notification/presentation/cubit/get_notification_cubit.dart';

class HomepageScreen extends StatefulWidget {
  final UserType userType;
  const HomepageScreen({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of< GetNotificationCubit>(context).fetchNotification(userId: context.read<AuthRepo>().getUserId()!);
  }
  @override
  Widget build(BuildContext context) {
    switch (widget.userType) {
      case UserType.student:
        return StudentScreen();
      case UserType.teacher:
        return TeacherScreen();
      case UserType.institute:
        return TeacherScreen();
    }
  }
}
