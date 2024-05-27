import 'package:equatable/equatable.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/courses_services_details/data/models/course_details_category_model.dart';
import 'package:khosousi_online/features/courses_services_details/data/models/course_details_teacher_model.dart';
import 'package:khosousi_online/features/courses_services_details/data/models/course_rate_model.dart';
import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_entity.dart';

class CourseDetailsModel extends CourseServiceDetailsEntity {
  CourseDetailsModel(
      {required super.id,
      required super.title,
      required super.isVip,
      required super.image,
      required super.presense,
      required super.online,
      required super.lastUpdate,
      required super.summary,
      required super.description,
      required super.country,
      required super.city,
      required super.countryCode,
      required super.categories,
      required super.teacher,
      required super.peopleRates,
      super.rate});

  factory CourseDetailsModel.fromJson(Map<String, dynamic> map) {
    Map<String, dynamic> info = map['course_info'];

    return CourseDetailsModel(
      id: info['Id'] ?? '',
      title: info['Title'] ?? '',
      isVip:
          info['Is_vip_course'] == null ? false : info['Is_vip_course'] == '1',
      image:
          info['Image_path'] == null || (info['Image_path'] as String).isEmpty
              ? EndPointsManager.coursesDefaultImageBaseUrl
              : EndPointsManager.coursesImageBaseUrl + info['Image_path'],
      presense: info['Teach_method_teacherHouse'] == null &&
              info['Teach_method_studentHouse'] == null
          ? false
          : (info['Teach_method_teacherHouse'] == '1' ||
              info['Teach_method_studentHouse'] == '1'),
      online: info['Teach_method_internet'] == null
          ? false
          : info['Teach_method_internet'] == '1',
      lastUpdate: info['Refresh_datetime'] as String,
      summary: info['Summary'] ?? '',
      description: info['Description'] ?? '',
      country: info['Country_name_ar'] ?? '',
      city: info['City_name_ar'] ?? '',
      countryCode: info['Country_code'] == null ||
              (info['Country_code'] as String).isEmpty
          ? ''
          : EndPointsManager.countryImageBaseUrl +
              info['Country_code'] +
              '.webp',

      // TODO: fetch course rate from API
      rate:
          map['courseRate'] != null ? map['courseRate'] as double : null,

      categories: (map['course_categories'] as List<dynamic>)
          .map(
            (e) => CourseDetailsCategoryModel.fromJson(e),
          )
          .toList(),
      teacher: CourseDetailsTeacherModel.fromJson(
          map['user_info'] as Map<String, dynamic>,
          map['courses_count'] ?? 0,
          map['user_avg_rating']['average'] == null
              ? null
              : double.tryParse(map['user_avg_rating']['average'] as String)),
      peopleRates: (map['reviews'] as List<dynamic>)
          .map(
            (e) => CourseRateModel.fromJson(
              map: e,
              teacherName:
               map['user_info']['User_name'] ?? '',
             teacherImage:  map['user_info']['Image_path'] == null ||
                      ( map['user_info']['Image_path'] as String).isEmpty
                  ?  map['user_info']['Jender'] == '0'
                      ? EndPointsManager.maleUserDefaultImageBaseUrl
                      : EndPointsManager.femaleUserDefaultImageBaseUrl
                  : EndPointsManager.userImageBaseUrl +  map['user_info']['Image_path'],
            ),
          )
          .toList(),
    );
  }
}
