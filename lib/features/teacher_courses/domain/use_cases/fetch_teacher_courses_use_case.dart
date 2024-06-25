// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';

import '../repositories/teacher_courses_repo.dart';

class FetchTeacherCoursesUseCase {
  final TeacherCoursesRepo teacherCoursesRepo;
  FetchTeacherCoursesUseCase({
    required this.teacherCoursesRepo,
  });
  Future<Either<Failure, List<TeacherCourseEntity>>> call(
      {required String userId}) async {
    final res = await teacherCoursesRepo.getCourses(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
