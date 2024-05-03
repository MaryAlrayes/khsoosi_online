// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherDetailsReviewEntity extends Equatable {
  final String id;
  final String userName;
  final String date;
  final String image;
  final String comment;
  final String reply;
  final double? rate;
  final String? voice;
  TeacherDetailsReviewEntity({
    required this.id,
    required this.userName,
    required this.date,
    required this.image,
    required this.comment,
    required this.reply,
    required this.rate,
    required this.voice,
  });

  @override
  List<Object?> get props => [
        id,
        userName,
        date,
        image,
        comment,
        reply,
        rate,
        voice,
      ];
}
