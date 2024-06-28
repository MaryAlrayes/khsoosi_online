
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/widgets/upload_certificates.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/accounts_repo.dart';
import '../../../../domain/use_cases/upload_certificates_use_case.dart';

part 'upload_certificates_state.dart';

class UploadCertificatesCubit extends Cubit<UploadCertificatesState> {
  final UploadCertificatesUseCase uploadCertificatesUseCase;
  UploadCertificatesCubit({
    required this.uploadCertificatesUseCase,
  }) : super(UploadCertificatesState.empty());

  void addImage(File image) {
    List<File> images = state.image;
    images.add(image);
    emit(state.copyWith(
        image: images,
        status: UploadCertificatesStatus.init,
        errorMessage: ''));
  }

  void deleteImage(File image) {
    List<File> images = state.image;
    images.remove(image);
    emit(state.copyWith(
        image: images,
        status: UploadCertificatesStatus.init,
        errorMessage: ''));
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        status: UploadCertificatesStatus.loading, errorMessage: ''));
    final res =
        await uploadCertificatesUseCase.call(image: state.image, userId: id);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(
          status: UploadCertificatesStatus.done, errorMessage: ''));
    });
  }
}

_mapFailureToState(emit, Failure f, UploadCertificatesState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(
          status: UploadCertificatesStatus.noInternet, errorMessage: ''));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          status: UploadCertificatesStatus.networkError,
          errorMessage: f.message));
  }
}
