// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/teacher_balance/domain/entities/teacher_balance_entity.dart';

import 'teacher_commissions_model.dart';

class TeacherBalanceModel extends TeacherBalanceEntity {
  TeacherBalanceModel(
      {required super.totalCharge,
      required super.lastCharge,
      required super.normalCallCount,
      required super.specialCallCount,
      required super.commissions});

  factory TeacherBalanceModel.fromJson(Map<String, dynamic> map) {
    List<dynamic> commissions = map['commissions'];

    return TeacherBalanceModel(
      totalCharge: map['total_charge']??'',
      lastCharge: map['last_charge']['Amount'] ??'',
      normalCallCount: map['normal_calls_count'] ??0,
      specialCallCount: map['special_calls_count'] ??0,
      commissions:List.generate(
       commissions.length,
        (index) => TeacherCommissionsModel.fromJson( commissions[index]),
      ).toList(),
    );
  }

}
