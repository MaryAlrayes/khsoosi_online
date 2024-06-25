// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherReviewEntity extends Equatable {
  final String id;
  final String userName;
  final String date;
  final String image;
  final String comment;
  final double? rate;
  final String? voice;
  final bool isWhatsAppActive;
  final String teacherReply;

  TeacherReviewEntity({
    required this.id,
    required this.userName,
    required this.date,
    required this.image,
    required this.comment,
    this.rate,
    this.voice,
    required this.isWhatsAppActive,
    required this.teacherReply,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        date,
        image,
        comment,
        rate,
        voice,
        teacherReply,
        isWhatsAppActive
      ];
}
