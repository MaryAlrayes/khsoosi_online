// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';
import '../../domain/entities/support_message_entity.dart';

class SupportMessageModel extends SupportMessageEntity {
  SupportMessageModel(
      {required super.id,
      required super.message,
      required super.date,
      required super.supportMessageUser,
      required super.isRead, required super.sendingNow});

      factory SupportMessageModel.fromJson(Map<String, dynamic> map) {
    return SupportMessageModel(
      id: map['Id'] as String,
      message: map['Message'] as String,
      date: DateTime.parse(map['MessageDateTime']),
      supportMessageUser: map['Is_Reply']=='1'?SupportMessageUser.support:SupportMessageUser.me,
      isRead: map['IsReaded'] =='1',
    sendingNow:false
    );
  }
}
