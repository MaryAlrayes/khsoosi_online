import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_review_entity.dart';

class TeacherDetailsReviewModel extends TeacherDetailsReviewEntity {
  TeacherDetailsReviewModel(
      {required super.id,
      required super.userName,
      required super.date,
      required super.image,
      required super.comment,
      required super.teacherReply,
      required super.teacherImage,
      required super.teacherName,
      required super.rate,
      required super.voice});

  factory TeacherDetailsReviewModel.fromJson(
      {required Map<String, dynamic> map,
      required int index,
      required String teacherName,
      required String teacherImage}) {
    dynamic info = map['review_info $index'];

    return TeacherDetailsReviewModel(
        id: info['Id'] ?? '',
        userName: info['Name'] ?? '',
        date: info['Review_datetime'] ?? '',
        image:
            info['Image_path'] == null || (info['Image_path'] as String).isEmpty
                ? info['Jender'] == '0'
                    ? EndPointsManager.maleUserDefaultImageBaseUrl
                    : EndPointsManager.femaleUserDefaultImageBaseUrl
                : EndPointsManager.reviewUserImageBaseUrl + info['Image_path'],
        comment: info['Comment'] ?? '',
        rate: info['Review_stars'] == null
            ? null
            : double.tryParse(info['Review_stars'] as String),
        voice: info['voice_record_file'] == null ||
                info['voice_record_file'].isEmpty
            ? null
            : EndPointsManager.voiceBaseUrl + info['voice_record_file'],
        teacherReply: info['reply'] ?? '',
        teacherImage:teacherImage ,
        teacherName:teacherName );
  }
}
