import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/helpers/age_calculator.dart';
import 'package:khosousi_online/features/search/data/models/teacher_speciality_model.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_certificates_model.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_courses_model.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_portofolio_model.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_review_model.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_services_model.dart';
import 'package:khosousi_online/features/teacher_details/data/model/teacher_universities_model.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

class TeacherDetailsModel extends TeacherDetailsEntity {
  TeacherDetailsModel(
      {required super.id,
      required super.name,
      required super.imagePath,
      required super.isVipAccount,
      required super.isSpecial,
      required super.residenseCountryEn,
      required super.residenseCountryAr,
      required super.residenseCityEn,
      required super.residenseCityAr,
      required super.residenseAddress,
      required super.residenseCountryCode,
      required super.nationalityAr,
      required super.nationalityEn,
      required super.nationalityCountryCode,
      required super.gender,
      required super.age,
      required super.elementary,
      required super.preparatory,
      required super.secondary,
      required super.university,
      required super.teachOnline,
      required super.teachPresence,
      required super.hasBioVideo,
      required super.youtubeBio,
      required super.lastDateActive,
      required super.isOnline,
      required super.averageRate,
      required super.teacherDescription,
      required super.teacherSpecialityEntity,
      required super.reviewEntity,
      required super.universities,
      required super.certificates,
      required super.courses,
      required super.portofolio,
      required super.services});

  factory TeacherDetailsModel.fromJson(List<dynamic> map) {
    dynamic info = map[0]['info'][0];
    dynamic teacherInfo = info['teacher_info'];

    dynamic teacherCategories = info['teacher_categories'];
    dynamic teacherCertificates = info['teacher_certificates'];
    dynamic teacherUniversities = info['teacher_universities'];

    dynamic courses = map[1]['courses'];
    dynamic services = map[2]['services'];
    dynamic reviews = map[3]['reviews'];
    dynamic portofolio = map[4]['portfolio'];

    return TeacherDetailsModel(
      id: teacherInfo['Id'] ?? '',
      name: teacherInfo['Name'] ?? '',
      imagePath: teacherInfo['Image_path'] == null ||
              (teacherInfo['Image_path'] as String).isEmpty
          ?teacherInfo['Jender'] == '0' ?  EndPointsManager.maleUserDefaultImageBaseUrl: EndPointsManager.femaleUserDefaultImageBaseUrl
          : EndPointsManager.userImageBaseUrl + teacherInfo['Image_path'],
      isVipAccount: teacherInfo['Is_vip_account'] == '1',
      isSpecial: teacherInfo['Is_special'] == '1',
      residenseCountryEn: teacherInfo['Country_of_residense_name_en'] ?? '',
      residenseCountryAr: teacherInfo['Country_of_residense_name_ar'] ?? '',
      residenseCityEn: teacherInfo['City_of_residense_name_en'] ?? '',
      residenseCityAr: teacherInfo['City_of_residense_name_ar'] ?? '',
      residenseAddress: teacherInfo['Address'] ?? '',
      residenseCountryCode: teacherInfo['Country_of_residense_code'] == null ||
              (teacherInfo['Country_of_residense_code'] as String).isEmpty
          ? ''
          : EndPointsManager.countryImageBaseUrl +
              teacherInfo['Country_of_residense_code'] +
              '.webp',
      nationalityAr: teacherInfo['nationality_name_ar'] ?? '',
      nationalityEn: teacherInfo['nationality_name_en'] ?? '',
      nationalityCountryCode: teacherInfo['nationality_country_code'] == null ||
              (teacherInfo['nationality_country_code'] as String).isEmpty
          ? ''
          : EndPointsManager.countryImageBaseUrl +
              teacherInfo['nationality_country_code'] +
              '.webp',
      gender: teacherInfo['Jender'] == '0' ? Gender.male : Gender.female,
      age: AgeCalculator.getAg(DateTime.parse(teacherInfo['Born_date'])),
      elementary: teacherInfo['Stage_elementry'] == null
          ? false
          : teacherInfo['Stage_elementry'] == '1',
      preparatory: teacherInfo['Stage_preparatory'] == null
          ? false
          : teacherInfo['Stage_preparatory'] == '1',
      secondary: teacherInfo['Stage_secondary'] == null
          ? false
          : teacherInfo['Stage_secondary'] == '1',
      university: teacherInfo['Stage_university'] == null
          ? false
          : teacherInfo['Stage_university'] == '1',
      teachOnline: teacherInfo['Teach_method_internet'] == null
          ? false
          : teacherInfo['Teach_method_internet'] == '1',
      teachPresence: teacherInfo['Teach_method_studentHouse'] == '1' ||
          teacherInfo['Teach_method_teacherHouse'] == '1' ||
          teacherInfo['root_by_offline_method_T'] == '1',
      hasBioVideo: teacherInfo['has_bio_video'] == null
          ? false
          : teacherInfo['has_bio_video'] == '1',
      youtubeBio: teacherInfo['bio_video'] ?? '',
      lastDateActive: teacherInfo['Last_activity_datetime'] ?? '',
      isOnline: (DateTime.now().millisecondsSinceEpoch -
                  (DateTime.parse(teacherInfo['Last_activity_datetime'])
                      .millisecondsSinceEpoch))
              .abs() <=
          40,
      averageRate: teacherInfo['average'] == null
          ? null
          : double.tryParse(teacherInfo['average'] as String),
      teacherDescription: teacherInfo['Skills'] ?? '',
      teacherSpecialityEntity: (teacherCategories as List<dynamic>)
          .map(
            (e) => TeacherSpecialityModel.fromJson(e),
          )
          .toList(),
      reviewEntity: List.generate(
        reviews.length,
        (index) => TeacherDetailsReviewModel.fromJson(
          reviews[index],
          index,
        ),
      ),
      universities: (teacherUniversities as List<dynamic>)
          .map(
            (e) => TeacherUniversitiesModel.fromJson(e),
          )
          .toList(),
      certificates: (teacherCertificates as List<dynamic>)
          .map(
            (e) => TeacherCertificatesModel.fromJson(e),
          )
          .toList(),
      courses: List.generate(
        courses.length,
        (index) => TeacherCoursesModel.fromJson(courses[index], index),
      ),
      portofolio: List.generate(
        portofolio.length,
        (index) => TeacherPortofolioModel.fromJson(portofolio[index], index),
      ),
      services: List.generate(
        services.length,
        (index) => TeacherServicesModel.fromJson(services[index], index),
      ),
    );
  }
}
