// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'upload_certificates_cubit.dart';

enum UploadCertificatesStatus { init, loading, done, noInternet, networkError }

class UploadCertificatesState extends Equatable {
  final List<File> image;
  final UploadCertificatesStatus status;
  final String errorMessage;
  const UploadCertificatesState({
    required this.image,
    required this.status,
    required this.errorMessage,
  });
  factory UploadCertificatesState.empty() {
    return UploadCertificatesState(
      image: [],
      status: UploadCertificatesStatus.init,
      errorMessage: '',
    );
  }

  @override
  List<Object> get props => [
    image,
    status,
    errorMessage,
  ];

  UploadCertificatesState copyWith({
    List<File>? image,
    UploadCertificatesStatus? status,
    String? errorMessage,
  }) {
    return UploadCertificatesState(
      image: image ?? this.image,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
