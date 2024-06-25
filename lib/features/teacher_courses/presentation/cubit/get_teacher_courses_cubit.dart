// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';

import '../../domain/use_cases/fetch_teacher_courses_use_case.dart';

part 'get_teacher_courses_state.dart';

class GetTeacherCoursesCubit extends Cubit<GetTeacherCoursesState> {
  final FetchTeacherCoursesUseCase fetchTeacherCoursesUseCase;
  GetTeacherCoursesCubit({
    required this.fetchTeacherCoursesUseCase,
  }) : super(GetTeacherCoursesInitial());

  void fetchCourses({required String userId}) async {
    emit(GetTeacherCoursesLoading());
    final res = await fetchTeacherCoursesUseCase.call(userId: userId);
    res.fold((f) {
      _mapFailureToState(emit, f);
    }, (data) {
      emit(GetTeacherCoursesLoaded(courses: data));
    });
  }
}

_mapFailureToState(emit, Failure f) {
  switch (f) {
    case OfflineFailure():
      emit(GetTeacherCoursesNoInternet());

    case NetworkErrorFailure f:
      emit(GetTeacherCoursesNetworkError(message: f.message));
  }
}
