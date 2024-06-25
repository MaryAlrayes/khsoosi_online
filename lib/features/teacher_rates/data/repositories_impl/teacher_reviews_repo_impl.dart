// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_rates/data/data_sources/teacher_review_data_source.dart';
import 'package:khosousi_online/features/teacher_rates/domain/entities/teacher_review_entity.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../domain/repositories/teacher_reviews_repo.dart';

class TeacherReviewsRepoImpl implements TeacherReviewsRepo {
  final TeacherReviewDataSource teacherReviewDataSource;
  TeacherReviewsRepoImpl({
    required this.teacherReviewDataSource,
  });
  Future<Either<Failure,List<TeacherReviewEntity>>> getReviews({required String userId})async{
     final data = await BaseRepo.repoRequest(
      request: () async {
        return await teacherReviewDataSource.getReviews(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));

  }

}
