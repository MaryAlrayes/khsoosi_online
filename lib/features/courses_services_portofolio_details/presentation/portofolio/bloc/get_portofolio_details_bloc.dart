// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/portofolio_details_entity.dart';
import '../../../domain/use cases/portofolio_details_use_case.dart';

part 'get_portofolio_details_event.dart';
part 'get_portofolio_details_state.dart';

class GetPortofolioDetailsBloc
    extends Bloc<GetPortofolioDetailsEvent, GetPortofolioDetailsState> {
  final PortofolioDetailsUseCase portofolioDetailsUseCase;
  GetPortofolioDetailsBloc({
    required this.portofolioDetailsUseCase,
  }) : super(GetPortofolioDetailsInitial()) {
    on<GetDetailsEvent>((event, emit) async{
    emit(GetPortofolioDetailsLoading());
          final res = await portofolioDetailsUseCase(id: event.id);
          res.fold((f) {
            _mapFailureToState(emit, f);
          }, (data) {
            emit(GetPortofolioDetailsLoaded(portofolioDetailsEntity : data));
          });
      }
    );
  }

  _mapFailureToState(emit, Failure f) {
    switch (f) {
      case OfflineFailure():
        emit(GetPortofolioDetailsNoInternet());

      case NetworkErrorFailure f:
        emit(GetPortofolioDetailsNetworkError(message: f.message));
    }
  }
}
