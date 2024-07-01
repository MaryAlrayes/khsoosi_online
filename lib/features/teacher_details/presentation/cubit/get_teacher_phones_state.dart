// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_teacher_phones_cubit.dart';

sealed class GetTeacherPhonesState extends Equatable {
  const GetTeacherPhonesState();

  @override
  List<Object> get props => [];
}

final class GetTeacherPhonesInitial extends GetTeacherPhonesState {}

final class GetTeacherPhonesLoading extends GetTeacherPhonesState {}

class GetTeacherPhonesLoaded extends GetTeacherPhonesState {
  final String number;
  final TeacherPhones type;
  GetTeacherPhonesLoaded({
    required this.number,
    required this.type,
  });
  @override
  List<Object> get props => [number,type];
}

class GetTeacherPhonesNoInternet extends GetTeacherPhonesState{

}
class GetTeacherPhonessNetworkError extends GetTeacherPhonesState {
  final String message;
  GetTeacherPhonessNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
