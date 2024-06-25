// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:khosousi_online/features/teacher_rates/data/repositories_impl/teacher_reviews_repo_impl.dart';

import '../../../../core/errors/failures.dart';
import '../entities/teacher_review_entity.dart';
import '../repositories/teacher_reviews_repo.dart';

class FetchReviewsUseCase {
  final TeacherReviewsRepo teacherReviewsRepo;
  FetchReviewsUseCase({
    required this.teacherReviewsRepo,
  });
   Future<Either<Failure,List<TeacherReviewEntity>>> call({required String userId})async{
 final res = await teacherReviewsRepo.getReviews(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));

   }
}
