// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_picture_cubit.dart';

enum UploadPictureStatus { init, loading, done, noInternet, networkError }

class UploadPictureState extends Equatable {
  final File? image;
  final UploadPictureStatus uploadPictureStatus;
  final String errorMessage;
  const UploadPictureState({
    required this.image,
    required this.uploadPictureStatus,
    required this.errorMessage,
  });

  factory UploadPictureState.empty() {
    return UploadPictureState(
      image: null,
      uploadPictureStatus: UploadPictureStatus.init,
      errorMessage: '',
    );
  }
  @override
  List<Object> get props => [
        image.hashCode,
        uploadPictureStatus,
        errorMessage,
      ];

  UploadPictureState copyWith({
    File? image,
    UploadPictureStatus? uploadPictureStatus,
    String? errorMessage,
  }) {
    return UploadPictureState(
      image: image ?? this.image,
      uploadPictureStatus: uploadPictureStatus ?? this.uploadPictureStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
