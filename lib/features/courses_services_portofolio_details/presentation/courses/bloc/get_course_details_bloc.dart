// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';

import '../../../domain/use cases/course_details_use_case.dart';

part 'get_course_details_event.dart';
part 'get_course_details_state.dart';

class GetCourseDetailsBloc extends Bloc<GetCourseDetailsEvent, GetCourseDetailsState> {
 final CourseDetailsUseCase courseDetailsUseCase;
  GetCourseDetailsBloc({
   required this.courseDetailsUseCase,
  }
  ) : super(GetCourseDetailsInitial()) {
    on<FetchCourseDetailsEvent>((event, emit)async {
      emit(GetCourseDetailsLoading());
          final res = await courseDetailsUseCase(id: event.id);
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetCourseDetailsLoaded(courseDetailsEntity: data));
          });
      }
    );
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetCourseDetailsNoInternet());

      case NetworkErrorFailure f:
        emit(GetCourseDetailsNetworkError(message: f.message));
    }
  }
}
