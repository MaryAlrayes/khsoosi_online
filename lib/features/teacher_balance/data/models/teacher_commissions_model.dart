// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/teacher_balance/domain/entities/teacher_commissions_entity.dart';

import '../../../../core/utils/helpers/date_formatter.dart';

class TeacherCommissionsModel extends TeacherCommissionsEntity {
  TeacherCommissionsModel(
      {required super.id,
      required super.paymentType,
      required super.amount,
      required super.amountUsd,
      required super.currencyAr,
      required super.currencyEn,
      required super.date});

  factory TeacherCommissionsModel.fromJson(Map<String, dynamic> map) {
    return TeacherCommissionsModel(
      id: map['Id']??'',
      paymentType: map['Name'] ??'',
      amount: map['Amount'] ??'',
      amountUsd: map['Amount_usd'] ??'',
      currencyAr: map['Name_ar'] ??'',
      currencyEn: map['Name_en'] ??'',
      date: DateTime.parse( map['Payment_date']) ,
    );
  }

}
