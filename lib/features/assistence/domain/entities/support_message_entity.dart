// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums/enums.dart';

class SupportMessageEntity extends Equatable {
  final String id;
  final String message;
  final DateTime date;
  final SupportMessageUser supportMessageUser;
  final bool isRead;
  final bool sendingNow;
  SupportMessageEntity({
    required this.id,
    required this.message,
    required this.date,
    required this.supportMessageUser,
    required this.isRead,
    required this.sendingNow,
  });

  @override
  List<Object?> get props => [
    id,
    message,
    date,
    supportMessageUser,
    isRead,sendingNow];



  SupportMessageEntity copyWith({
    String? id,
    String? message,
    DateTime? date,
    SupportMessageUser? supportMessageUser,
    bool? isRead,
    bool? sendingNow,
  }) {
    return SupportMessageEntity(
      id: id ?? this.id,
      message: message ?? this.message,
      date: date ?? this.date,
      supportMessageUser: supportMessageUser ?? this.supportMessageUser,
      isRead: isRead ?? this.isRead,
      sendingNow: sendingNow ?? this.sendingNow,
    );
  }
}
