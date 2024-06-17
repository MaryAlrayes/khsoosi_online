// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

class InstituteExtraInfoEntity extends Equatable {
  final String name;
  final String about;
  final String address;
  final List<CategoryEntity> categories;
  InstituteExtraInfoEntity({
    required this.name,
    required this.about,
    required this.address,
    required this.categories,
  });
  @override
  List<Object?> get props => [
        name,
        about,
        address,
        categories,
      ];

  factory InstituteExtraInfoEntity.empty() {
    return InstituteExtraInfoEntity(
      name: '',
      about: '',
      address: '',
      categories: [],
    );
  }

  InstituteExtraInfoEntity copyWith({
    String? name,
    String? about,
    String? address,
    List<CategoryEntity>? categories,
  }) {
    return InstituteExtraInfoEntity(
      name: name ?? this.name,
      about: about ?? this.about,
      address: address ?? this.address,
      categories: categories ?? this.categories,
    );
  }
}
