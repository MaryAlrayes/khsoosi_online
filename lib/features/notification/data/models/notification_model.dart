// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.type,
    required super.text,
    required super.date,
    required super.isRead,
  });

   factory NotificationModel.fromJson(Map<String, dynamic> map,int index) {
    return NotificationModel(
      id: map['Id'] as String,
      type: map['Notification_type'] as String,
      text: map['Notification_text'] as String,
      date:DateTime.parse( map['Publish_datetime']),
      isRead: map['Is_Readed']=='1',

    );
  }
}
