import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_rate_entity.dart';

class ServiceRateModel extends CourseServiceRateEntity {
  ServiceRateModel(
      {required super.id,
      required super.userName,
      required super.date,
      required super.image,
      required super.comment,
      required super.teacherReply,
      required super.teacherName,
      required super.teacherImage,
      super.rate,
      super.voice});

  factory ServiceRateModel.fromJson(
      {required Map<String, dynamic> map,
      required String teacherName,
      required String teacherImage}) {
    return ServiceRateModel(
      id: map['Id'] ?? '',
      userName: map['Student_name'] ?? '',
      date: map['Review_datetime'] ?? '',
      image: map['Image_path'] == null || (map['Image_path'] as String).isEmpty
          ? map['Jender'] == '0'
              ? EndPointsManager.maleUserDefaultImageBaseUrl
              : EndPointsManager.femaleUserDefaultImageBaseUrl
          : EndPointsManager.reviewUserImageBaseUrl + map['Image_path'],
      comment: map['Comment'] ?? '',
      rate: map['Review_stars'] == null
          ? null
          : double.tryParse(map['Review_stars'] as String),
       voice: map['voice_record_file'] == null ||
                map['voice_record_file'].isEmpty
            ? null
            : EndPointsManager.voiceBaseUrl + map['voice_record_file'],
        teacherReply: map['reply'] ?? '',
        teacherImage:teacherImage ,
        teacherName:teacherName
    );
  }
}
