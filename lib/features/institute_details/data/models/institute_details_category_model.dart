import 'package:khosousi_online/features/institute_details/domain/entities/insitute_details_category_entity.dart';

class InstituteDetailsCategoryModel extends InstituteDetailsCategoryEntity {
  InstituteDetailsCategoryModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
  });


  factory InstituteDetailsCategoryModel.fromJson(Map<String, dynamic> map) {
    return InstituteDetailsCategoryModel(
      id: map['Id'] ??'',
      nameAr: map['Name_ar'] ??'',
      nameEn: map['Name_en'] ??'',
    );
  }
}
