// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../domain/entities/university_entity.dart';

class UniversityModel extends UniversityEntity {

  UniversityModel({
    required super.id,
    required super.name,
  });
  factory UniversityModel.fromJson(Map<String, dynamic> map) {
    return UniversityModel(
      id: map['Id'] as String,
      name:map['Name'] as String,
    );
  }

}
