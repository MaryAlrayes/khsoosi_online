// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_search_cubit.dart';

class FilterSearchState extends Equatable {
  final SearchFilterEntity filter;
  final SearchFilterEntity previousfilter;

  FilterSearchState({
    required this.filter,
    required this.previousfilter,
  });

  factory FilterSearchState.empty() {
    return FilterSearchState(
      filter: SearchFilterEntity.empty(),
      previousfilter: SearchFilterEntity.empty()
    );
  }

  @override
  List<Object> get props => [filter,previousfilter];

  FilterSearchState copyWith({
   SearchFilterEntity? filter,
    SearchFilterEntity? previous,
  }) {
    return FilterSearchState(
      filter: filter?? this.filter,
      previousfilter: previous?? this.previousfilter
    );
  }
}
