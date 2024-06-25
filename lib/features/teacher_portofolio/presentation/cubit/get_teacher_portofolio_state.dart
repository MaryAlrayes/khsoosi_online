part of 'get_teacher_portofolio_cubit.dart';

sealed class GetTeacherPortofolioState extends Equatable {
  const GetTeacherPortofolioState();

  @override
  List<Object> get props => [];
}

final class GetTeacherPortofolioInitial extends GetTeacherPortofolioState {}

final class GetTeacherPortofolioLoading extends GetTeacherPortofolioState {}

 class GetTeacherPortofolioLoaded extends GetTeacherPortofolioState {
  final List<TeacherPortofolioEntity> portfolio;
  GetTeacherPortofolioLoaded({required this.portfolio});
  @override
  List<Object> get props => [portfolio];
}

class GetTeacherPortofolioNoInternet extends GetTeacherPortofolioState{

}
class GetTeacherPortofolioNetworkError extends GetTeacherPortofolioState {
  final String message;
  GetTeacherPortofolioNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
