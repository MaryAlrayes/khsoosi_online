// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_institute_details_bloc.dart';

sealed class GetInstituteDetailsEvent extends Equatable {
  const GetInstituteDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadInstitutesDetailsEvent extends GetInstituteDetailsEvent {
  final String id;
  LoadInstitutesDetailsEvent({
    required this.id,
  });
}
