// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_categories_bloc.dart';

sealed class GetCategoriesState extends Equatable {
  const GetCategoriesState();

  @override
  List<Object> get props => [];
}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

 class GetCategoriesLoaded extends GetCategoriesState {
  final List<CategoryEntity> categories;
  GetCategoriesLoaded({required this.categories});
  @override
  List<Object> get props => [categories];
}

class GetCategoriesNoInternet extends GetCategoriesState{

}
class GetCategoriesNetworkError extends GetCategoriesState {
  final String message;
  GetCategoriesNetworkError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
