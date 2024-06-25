// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeacherServiceEntity extends Equatable {
final String id;
final String name;
final String isActive;
final String isUpdated;
final bool isAccepted;
final bool isRejected;
final bool isPending;
final List<String> categories;
final String image;
  TeacherServiceEntity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.isUpdated,
    required this.isAccepted,
    required this.isRejected,
    required this.isPending,
    required this.categories,
    required this.image,
  });

  @override
  List<Object?> get props => [

    id,
    name,
    isActive,
    isUpdated,
    isAccepted,
    isRejected,
    isPending,
    categories,
    image
  ];




 }
