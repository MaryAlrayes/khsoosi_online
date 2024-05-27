import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/search/data/models/teacher_category_model.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';

class TeacherModel extends TeacherEntity {
  TeacherModel(
      {
    required   super.id,
    required   super.name,
    required   super.imagePath,
    required   super.isVipAccount,
    required   super.isSpecial,
    required   super.address,
    required   super.teachMethodInternet,
    required   super.teachMethodStudentHouse,
    required   super.teachMethodTeacherHouse,
    required   super.hasBioVideo,
    required   super.teachMethodOfflineByRoot,
      super.average,
    required  super.countryEn,
    required  super.countryAr,
    required  super.cityEn,
    required  super.cityAr,
     required super.countryCode,
     required super.teacherSpecialityEntity
      });
  factory TeacherModel.fromJson(Map<String, dynamic> json, int index) {
    dynamic data = json['teacher_info $index'];
    dynamic categories = json['teacher_categories $index'];
      return TeacherModel(
        id: data['Id'] ??'',
        name: data['Name'] ?? '',
        imagePath:
        data['Image_path']==null || (data['Image_path'] as String).isEmpty
            ? data['Jender'] == '0' ?  EndPointsManager.maleUserDefaultImageBaseUrl: EndPointsManager.femaleUserDefaultImageBaseUrl
            : EndPointsManager.userImageBaseUrl + data['Image_path'] ,
        isVipAccount: data['Is_vip_account'] == '1' ? true : false,
        isSpecial: data['Is_special'] == '1' ? true : false,
        address: data['Address'] ?? '',
        countryAr: data['Country_of_residense_Name_ar'] ?? '',
        countryEn: data['Country_of_residense_Name_en'] ?? '',
        cityAr: data['City_of_residense_Name_ar'] ?? '',
        cityEn: data['City_of_residense_Name_en'] ?? '',
        teachMethodInternet:
            data['Teach_method_internet'] == '1' ? true : false,
        teachMethodStudentHouse:
            data['Teach_method_studentHouse'] == '1' ? true : false,
        teachMethodTeacherHouse:
            data['Teach_method_teacherHouse'] == '1' ? true : false,
        hasBioVideo: data['has_bio_video'] == '1' ? true : false,
        teachMethodOfflineByRoot:
            data['Teach_method_offline_by_root'] == '1' ? true : false,
        average: data['average'] == null
            ? null
            : double.tryParse(data['average'] as String),
        countryCode: data['Country_code']==null||(data['Country_code'] as String).isEmpty
            ? ''
            : EndPointsManager.countryImageBaseUrl +
                data['Country_code'] +
                '.webp',
        teacherSpecialityEntity:
            (categories as List<dynamic>)
                .map(
                  (e) => TeacherCategoryModel.fromJson(e),
                )
                .toList()
        );
  }
}
