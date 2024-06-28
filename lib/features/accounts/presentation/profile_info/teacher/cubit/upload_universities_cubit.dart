// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../shared_features/domain/entities/university_entity.dart';
import '../../../../domain/use_cases/upload_universities_use_case.dart';

part 'upload_universities_state.dart';

class UploadUniversitiesCubit extends Cubit<UploadUniversitiesState> {
  final UploadUniversitiesUseCase uploadUniversitiesUseCase;
  UploadUniversitiesCubit({
    required this.uploadUniversitiesUseCase,
  }) : super(UploadUniversitiesState.empty());
  void addUniversity(UniversityEntity university) {
    List<UniversityEntity> universities = state.universities;
    universities.add(university);
    emit(state.copyWith(
        universities: universities,
        uploadUniversitiesStatus: UploadUniversitiesStatus.init,
        error: ''));
  }

  void deleteUniversity(UniversityEntity university) {
    List<UniversityEntity> universities = state.universities;
    universities.remove(university);
    emit(state.copyWith(
        universities: universities,
        uploadUniversitiesStatus: UploadUniversitiesStatus.init,
        error: ''));
  }

  void changeCourses(String courses) {
    emit(state.copyWith(
        courses: courses,
        uploadUniversitiesStatus: UploadUniversitiesStatus.init,
        error: ''));
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        uploadUniversitiesStatus: UploadUniversitiesStatus.loading, error: ''));
    final res = await uploadUniversitiesUseCase.call(
        universities: state.universities, userId: id, courses: state.courses);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(
          uploadUniversitiesStatus: UploadUniversitiesStatus.done, error: ''));
    });
  }
}

_mapFailureToState(emit, Failure f, UploadUniversitiesState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(
          uploadUniversitiesStatus: UploadUniversitiesStatus.noInternet, error: ''));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          uploadUniversitiesStatus: UploadUniversitiesStatus.networkError,
          error: f.message));
  }
}
