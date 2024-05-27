// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/rates/domain/entities/rate_entity.dart';

class CourseServiceRateEntity extends RateEntity {
  CourseServiceRateEntity(
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
}
