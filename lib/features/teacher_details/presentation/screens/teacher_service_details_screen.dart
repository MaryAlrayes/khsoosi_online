// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/courses/screens/course_details_screen.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/services/screens/service_details_screen.dart';

class TeacherServiceDetailsScreen extends StatelessWidget {
   static const routeName = 'teacher_service_details_screen';

  final String serviceId;
  const TeacherServiceDetailsScreen({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ServiceDetailsScreen(id: serviceId);
  }
}
