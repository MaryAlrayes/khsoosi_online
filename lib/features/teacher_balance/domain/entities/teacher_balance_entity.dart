// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'teacher_commissions_entity.dart';

class TeacherBalanceEntity extends Equatable {
  final String totalCharge;
  final String lastCharge;
  final int normalCallCount;
  final int specialCallCount;
  final List<TeacherCommissionsEntity> commissions;
  TeacherBalanceEntity({
    required this.totalCharge,
    required this.lastCharge,
    required this.normalCallCount,
    required this.specialCallCount,
    required this.commissions,
  });

  @override
  List<Object?> get props => [
    totalCharge,
    lastCharge,
    normalCallCount,
    specialCallCount,
    commissions,];


}
