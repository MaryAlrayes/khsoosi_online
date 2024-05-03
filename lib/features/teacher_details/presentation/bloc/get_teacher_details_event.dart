// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_teacher_details_bloc.dart';

sealed class GetTeacherDetailsEvent extends Equatable {
  const GetTeacherDetailsEvent();

  @override
  List<Object> get props => [];
}
class LoadTeacherDetails extends GetTeacherDetailsEvent {
  final String id;
  LoadTeacherDetails({
    required this.id,
  });
}
