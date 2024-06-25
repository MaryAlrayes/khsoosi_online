// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String type;
  final String text;
  final DateTime date;
  final bool isRead;
  NotificationEntity({
    required this.id,
    required this.type,
    required this.text,
    required this.date,
    required this.isRead,
  });

  @override

  List<Object?> get props =>[
    id,
    type,
    text,
    date,
    isRead,
  ];


 
}
