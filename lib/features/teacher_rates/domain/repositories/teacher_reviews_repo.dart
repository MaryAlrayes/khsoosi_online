import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_rates/domain/entities/teacher_review_entity.dart';

abstract class TeacherReviewsRepo{
  Future<Either<Failure,List<TeacherReviewEntity>>> getReviews({required String userId});

}
