// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/errors/failures.dart';

import '../../../../domain/use_cases/upload_picture_use_case.dart';

part 'upload_picture_state.dart';

class UploadPictureCubit extends Cubit<UploadPictureState> {
  final UploadPictureUseCase uploadPictureUseCase;
  UploadPictureCubit({
    required this.uploadPictureUseCase,
  }) : super(UploadPictureState.empty());
  void setPicture(File image) {
    emit(state.copyWith(image: image,uploadPictureStatus: UploadPictureStatus.init,errorMessage: ''));
  }

  void submit({required String id}) async {
    emit(state.copyWith(
        uploadPictureStatus: UploadPictureStatus.loading, errorMessage: ''));
    final res =
        await uploadPictureUseCase.call(image: state.image!, userId: id);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(
          uploadPictureStatus: UploadPictureStatus.done, errorMessage: ''));
    });
  }
}

_mapFailureToState(emit, Failure f, UploadPictureState state) {
  switch (f) {
    case OfflineFailure():
      emit(state.copyWith(
          uploadPictureStatus: UploadPictureStatus.noInternet,
          errorMessage: ''));

    case NetworkErrorFailure f:
      emit(state.copyWith(
          uploadPictureStatus: UploadPictureStatus.networkError,
          errorMessage: f.message));
  }
}
