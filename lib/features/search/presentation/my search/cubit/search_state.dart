part of 'search_cubit.dart';

 class SearchState extends Equatable {
  final SearchType searchType;
  const SearchState({required this.searchType});

  @override
  List<Object> get props => [searchType];
}

