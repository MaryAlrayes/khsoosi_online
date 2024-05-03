// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/use%20cases/get_teaches_details_use_case.dart';

import '../../../../core/errors/failures.dart';

part 'get_teacher_details_event.dart';
part 'get_teacher_details_state.dart';

class GetTeacherDetailsBloc
    extends Bloc<GetTeacherDetailsEvent, GetTeacherDetailsState> {
  final GetTeacherDetailsUseCase getTeacherDetailsUseCase;
  GetTeacherDetailsBloc({
    required this.getTeacherDetailsUseCase,
  }) : super(GetTeacherDetailsInitial()) {
    on<GetTeacherDetailsEvent>((event, emit) async {
      switch (event) {
        
        case LoadTeacherDetails():
          emit(GetTeacherDetailsLoading());
          final res = await getTeacherDetailsUseCase(id: event.id);
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetTeacherDetailsLoaded(teacherDetailsEntity: data));
          });
      }
    });
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetGetTeacherDetailsLoadedNoInternet());

      case NetworkErrorFailure f:
        emit(GetGetTeacherDetailsLoadedNetworkError(message: f.message));
    }
  }
}
