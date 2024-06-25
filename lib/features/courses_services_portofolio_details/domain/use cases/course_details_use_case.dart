import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/repositories/course_details_repo.dart';
import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

class CourseDetailsUseCase {
  final CourseDetailsRepo courseDetailsRepo;
  CourseDetailsUseCase({
    required this.courseDetailsRepo,
  });
  Future<Either<Failure, CourseServiceDetailsEntity>> call(
      {required String id}) async {
    final res = await courseDetailsRepo.getCourseDetails(id: id);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
