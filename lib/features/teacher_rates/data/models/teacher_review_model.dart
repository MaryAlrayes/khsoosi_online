import 'package:equatable/equatable.dart';

import '../../../../core/managers/endpoints_manager.dart';
import '../../domain/entities/teacher_review_entity.dart';

class TeacherReviewModel extends TeacherReviewEntity{

  TeacherReviewModel({
    required super.id,
    required super.userName,
    required super.date,
    required super.image,
    required super.comment,
    required super.isWhatsAppActive,
    super.rate,
    super.voice,
    required super.teacherReply,

  });


  factory TeacherReviewModel.fromJson(Map<String, dynamic> map,int index) {
    Map<String,dynamic> info = map['review_info $index'];
    return TeacherReviewModel(
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
        isWhatsAppActive: info['Is_active_whatsapp']=='1'
    );
  }

}
