part of 'teacher_extra_info_cubit.dart';

enum TeacherExtraInfoStatus { init, loading, done, noInternet, networkError }

class TeacherExtraInfoState extends Equatable {
  final TeacherExtraInfoEntity teacherExtraInfoEntity;
  final TeacherExtraInfoStatus teacherExtraInfoStatus;
  final String errorMessage;
  TeacherExtraInfoState({
    required this.teacherExtraInfoEntity,
    required this.teacherExtraInfoStatus,
    required this.errorMessage,
  });

  factory TeacherExtraInfoState.empty() {
    return TeacherExtraInfoState(
        errorMessage: '',
        teacherExtraInfoEntity: TeacherExtraInfoEntity.empty(),
        teacherExtraInfoStatus: TeacherExtraInfoStatus.init);
  }
  @override
  List<Object> get props => [
        teacherExtraInfoEntity,
        teacherExtraInfoStatus,
        errorMessage,
      ];

  TeacherExtraInfoState copyWith({
    TeacherExtraInfoEntity? info,
    TeacherExtraInfoStatus? teacherinfoStatus,
    String? errorMessage,
  }) {
    return TeacherExtraInfoState(
      teacherExtraInfoEntity: info ?? this.teacherExtraInfoEntity,
      teacherExtraInfoStatus: teacherinfoStatus ?? this.teacherExtraInfoStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool get stringify => true;
}
