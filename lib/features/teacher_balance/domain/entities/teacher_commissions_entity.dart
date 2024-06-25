// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherCommissionsEntity extends Equatable {
  final String id;
  final String paymentType;
  final String amount;
  final String amountUsd;
  final String currencyAr;
  final String currencyEn;
  final DateTime date;
  TeacherCommissionsEntity({
    required this.id,
    required this.paymentType,
    required this.amount,
    required this.amountUsd,
    required this.currencyAr,
    required this.currencyEn,
    required this.date,
  });
  @override
  List<Object?> get props => [
    id,
    paymentType,
    amount,
    amountUsd,
    currencyAr,
    currencyEn,
    date
  ];

}
