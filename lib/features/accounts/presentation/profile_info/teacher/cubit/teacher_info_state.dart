// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'teacher_info_cubit.dart';

enum TeacherinfoStatus { init, loading, done, noInternet, networkError }

class TeacherInfoState extends Equatable {
  final TeacherContactInfoEntity teacherInfoEntity;
  final TeacherinfoStatus teacherinfoStatus;
  final String errorMessage;
  TeacherInfoState({
    required this.teacherInfoEntity,
    required this.teacherinfoStatus,
    required this.errorMessage,
  });

  factory TeacherInfoState.empty() {
    return TeacherInfoState(
        errorMessage: '',
        teacherInfoEntity: TeacherContactInfoEntity.empty(),
        teacherinfoStatus: TeacherinfoStatus.init);
  }
  @override
  List<Object> get props => [
        teacherInfoEntity,
        teacherinfoStatus,
        errorMessage,
      ];

  TeacherInfoState copyWith({
    TeacherContactInfoEntity? info,
    TeacherinfoStatus? teacherinfoStatus,
    String? errorMessage,
  }) {
    return TeacherInfoState(
        teacherInfoEntity: info ?? this.teacherInfoEntity,
        teacherinfoStatus: teacherinfoStatus ?? this.teacherinfoStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  bool get stringify => true;
}
