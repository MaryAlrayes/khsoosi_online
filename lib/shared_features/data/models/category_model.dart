import 'package:khosousi_online/shared_features/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name_ar,
    required super.name_en,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Id': id,
      'Name_ar': name_ar,
      'Name_en': name_en,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['Id'] as String,
      name_ar: map['Name_ar'] as String,
      name_en: map['Name_en'] as String,
    );
  }
}
