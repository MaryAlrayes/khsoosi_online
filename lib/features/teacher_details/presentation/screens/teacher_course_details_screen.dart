// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/courses/screens/course_details_screen.dart';

class TeacherCourseDetailsScreen extends StatelessWidget {
   static const routeName = 'teacher_courses_details_screen';

  final String courseId;
  const TeacherCourseDetailsScreen({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CourseDetailsScreen(id: courseId);
  }
}
