import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(searchType: SearchType.teachers));
  
  void setType(SearchType searchType){
    emit(SearchState(searchType:searchType));
  }
}
