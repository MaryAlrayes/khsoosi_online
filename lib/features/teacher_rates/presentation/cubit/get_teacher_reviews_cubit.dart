import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/teacher_review_entity.dart';
import '../../domain/use_cases/fetch_reviews_use_case.dart';

part 'get_teacher_reviews_state.dart';

class GetTeacherReviewsCubit extends Cubit<GetTeacherReviewsState> {
final FetchReviewsUseCase fetchReviewsUseCase;
  GetTeacherReviewsCubit({required this.fetchReviewsUseCase}) : super(GetTeacherReviewsInitial());
 void fetchReviews({required String userId}) async {
    emit(GetTeacherReviewsLoading());
    final res = await fetchReviewsUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetTeacherReviewsLoaded(reviews: data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherReviewsNoInternet());

    case NetworkErrorFailure f:
      emit(GetTeacherReviewsNetworkError(message: f.message));
  }
}
