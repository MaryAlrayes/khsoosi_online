// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';
import 'package:khosousi_online/shared_features/domain/use_cases/get_categories_use_case.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  GetCategoriesBloc({
    required this.getCategoriesUseCase,
  }) : super(GetCategoriesInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      switch (event) {
        case LoadCategoriesEvent():
          emit(GetCategoriesLoading());
          final res = await getCategoriesUseCase();
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetCategoriesLoaded(categories: data));
          });
      }
    });
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetCategoriesNoInternet());

      case NetworkErrorFailure f:
        emit(GetCategoriesNetworkError(message: f.message));
    }
  }
}
