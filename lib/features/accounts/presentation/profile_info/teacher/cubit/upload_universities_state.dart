// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_universities_cubit.dart';

enum UploadUniversitiesStatus { init, loading, done, noInternet, networkError }

class UploadUniversitiesState extends Equatable {
  final List<UniversityEntity> universities;
  final String courses;
  final UploadUniversitiesStatus uploadUniversitiesStatus;
  final String error;
  const UploadUniversitiesState({
    required this.universities,
    required this.courses,
    required this.uploadUniversitiesStatus,
    required this.error,
  });
  factory UploadUniversitiesState.empty() {
    return UploadUniversitiesState(
      universities: [],
      courses: '',
      error: '',
      uploadUniversitiesStatus: UploadUniversitiesStatus.init,
    );
  }
  @override
  List<Object> get props => [
        universities,
        courses,
        uploadUniversitiesStatus,
        error,
      ];

  UploadUniversitiesState copyWith({
    List<UniversityEntity>? universities,
    String? courses,
    UploadUniversitiesStatus? uploadUniversitiesStatus,
    String? error,
  }) {
    return UploadUniversitiesState(
      universities: universities ?? this.universities,
      courses: courses ?? this.courses,
      uploadUniversitiesStatus: uploadUniversitiesStatus ?? this.uploadUniversitiesStatus,
      error: error ?? this.error,
    );
  }
}
