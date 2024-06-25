import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/institute_details/data/models/institute_details_category_model.dart';
import 'package:khosousi_online/features/institute_details/data/models/institute_details_course_model.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_entity.dart';

class InstituteDetailsModel extends InstituteDetailsEntity {
  InstituteDetailsModel(
      {required super.id,
      required super.name,
      required super.job,
      required super.email,
      required super.image,
      required super.description,
      required super.mobile,
      required super.mobileCountryCode,
      required super.whatsapp,
      required super.whatsappCountryCode,
      required super.country,
      required super.city,
      required super.countryImageCode,
      required super.address,
      required super.coursesNumber,
      required super.numberOfStages,
      required super.eductaionalMethod,
      required super.categories,
      required super.courses});

  factory InstituteDetailsModel.fromJson(List<dynamic> map) {
    Map<String, dynamic> info = map[0]['info'][0]['institute_info'];
    List<dynamic> categories = map[0]['info'][0]['institute_categories'];
    List<dynamic> courses = map[1]['courses'];
    return InstituteDetailsModel(
      id: info['Id'] ?? '',
      name: info['Name_en'] ?? '',
      //Todo:missing job from api
      job: info['job'] ?? 'Graphic Designer',
      email: info['Email'] ?? '',
      image:
          info['Image_path'] == null || (info['Image_path'] as String).isEmpty
              ? EndPointsManager.instituteDefaultImageBaseUrl
              : EndPointsManager.instituteDetailsBaseUrl + info['Image_path'],
      description: info['About'] ?? '',
      mobile: info['Mobile'] ?? '',
      mobileCountryCode: info['mobile_code'] ?? '',
      whatsapp: info['Whatsapp'] ?? '',
      whatsappCountryCode: info['whatsapp_code'] ?? '',
      country: info['Country_of_residense_name_ar'] ?? '',
      city: info['City_of_residense_name_ar'] ?? '',
      countryImageCode: info['Country_of_residense_code'] ?? '',
      address: info['Address'] ?? '',
      coursesNumber: courses.length,
      //todo:missing number of stages  and educational methods from APi
      numberOfStages: info['numberOfStages'] ?? 0,
      eductaionalMethod: info['eductaionalMethod'] ?? 0,
      categories: (categories as List<dynamic>)
          .map(
            (e) => InstituteDetailsCategoryModel.fromJson(e),
          )
          .toList(),
      courses: List.generate(
        courses.length,
        (index) => InstituteDetailsCourseModel.fromJson(courses[index], index),
      ),
    );
  }
}
