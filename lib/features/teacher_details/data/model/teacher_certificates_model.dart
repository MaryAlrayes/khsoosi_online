import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_certificates_entity.dart';

class TeacherCertificatesModel extends TeacherCertificatesEntity {
  TeacherCertificatesModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.image});

  factory TeacherCertificatesModel.fromJson(Map<String, dynamic> map) {
    return TeacherCertificatesModel(
        id: map['Id'] ?? '',
        name: map['Name'] ?? '',
        description: map['Description'] ?? '',
        image:
            map['Image_path'] == null || (map['Image_path'] as String).isEmpty
                ? EndPointsManager.certificateDefaultImageBaseUrl
                : EndPointsManager.certificateImageBaseUrl + map['Image_path']);
  }
}
