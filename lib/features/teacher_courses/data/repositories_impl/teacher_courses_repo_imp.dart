// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_courses/data/data_sources/teacher_courses_data_source.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_courses/domain/repositories/teacher_courses_repo.dart';

class TeacherCoursesRepoImpl implements TeacherCoursesRepo {
  final TeacherCoursesDataSource teacherCoursesDataSource;
  TeacherCoursesRepoImpl({
    required this.teacherCoursesDataSource,
  });

  Future<Either<Failure, List<TeacherCourseEntity>>> getCourses(
      {required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherCoursesDataSource.getCourses(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
