part of 'get_teacher_reviews_cubit.dart';

sealed class GetTeacherReviewsState extends Equatable {
  const GetTeacherReviewsState();

  @override
  List<Object> get props => [];
}

final class GetTeacherReviewsInitial extends GetTeacherReviewsState {}

final class GetTeacherReviewsLoading extends GetTeacherReviewsState {}

 class GetTeacherReviewsLoaded extends GetTeacherReviewsState {
  final List<TeacherReviewEntity> reviews;
  GetTeacherReviewsLoaded({required this.reviews});
  @override
  List<Object> get props => [reviews];
}

class GetTeacherReviewsNoInternet extends GetTeacherReviewsState{

}
class GetTeacherReviewsNetworkError extends GetTeacherReviewsState {
  final String message;
  GetTeacherReviewsNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
