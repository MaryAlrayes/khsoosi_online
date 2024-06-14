// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'student_info_cubit.dart';

enum StudentInfoStatus { init, loading, done, noInternet, networkError }

class StudentInfoState extends Equatable {
  final StudentContactInfoEntity studentInfoEntity;
  final StudentInfoStatus studentInfoStatus;
  final String errorMessage;
  const StudentInfoState({
    required this.studentInfoEntity,
    required this.studentInfoStatus,
    required this.errorMessage,
  });
  factory StudentInfoState.empty() {
    return StudentInfoState(
        errorMessage: '',
        studentInfoEntity: StudentContactInfoEntity.empty(),
        studentInfoStatus: StudentInfoStatus.init);
  }
  @override
  List<Object> get props => [
        studentInfoEntity,
        studentInfoStatus,
        errorMessage,
      ];

  StudentInfoState copyWith({
    StudentContactInfoEntity ? info,
    StudentInfoStatus? studentInfoStatus,
    String? errorMessage,
  }) {
    return StudentInfoState(
        studentInfoEntity: info?? this.studentInfoEntity,
        studentInfoStatus: studentInfoStatus ?? this.studentInfoStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  bool get stringify => true;
}
