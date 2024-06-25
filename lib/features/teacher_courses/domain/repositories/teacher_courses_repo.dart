import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';

abstract class TeacherCoursesRepo {
  Future<Either<Failure, List<TeacherCourseEntity>>> getCourses({required String userId});
}
