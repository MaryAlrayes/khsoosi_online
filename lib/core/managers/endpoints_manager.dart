class EndPointsManager {
  static const String baseAppUrl = "https://teacherprivate.com/";

//countries
  static const String countryImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/countries/png/48/";

//user
  static const String userImageBaseUrl = "${baseAppUrl}assets/images/users/";
static const String maleUserDefaultImageBaseUrl = "${baseAppUrl}assets/template_files/images/male-teacher.webp";
static const String femaleUserDefaultImageBaseUrl = "${baseAppUrl}assets/template_files/images/female-teacher.webp";

  //certificates
  static const String certificateImageBaseUrl =
      "${baseAppUrl}assets/images/users/portfolios/";
  static const String certificateDefaultImageBaseUrl =
      "${baseAppUrl}/assets/template_files/images/logokhsoosi.webp";

//courses
  static const String coursesImageBaseUrl =
      "${baseAppUrl}assets/images/courses/";
  static const String coursesDefaultImageBaseUrl =
      "${baseAppUrl}assets/images/courses/default/default.webp";

//portofilio
  static const String portofolioImageBaseUrl =
      "${baseAppUrl}assets/images/portfolio/";
  static const String portofolioDefaultImageBaseUrl =
      "${baseAppUrl}assets/images/portfolio/default/default.webp";

//reviews
  static const String reviewUserImageBaseUrl =
      "${baseAppUrl}assets/images/users/";
  static const String voiceBaseUrl = "${baseAppUrl}assets/reviews_records/";

//services
 static const String servicesImageBaseUrl =
      "${baseAppUrl}assets/images/services/";
  static const String servicesDefaultImageBaseUrl =
      "${baseAppUrl}assets/images/services/default/default.webp";

  static const String getCategories = "users/get_categories_tags";
  static const String getCountries = "countries/get_all_countries";
  static const String getCities = "countries/get_cities_by_country_api";

  static const String getAllTeachers = "Teachers/get_all_teachers_api";
  static const String getTeachersbyFilter = "API/Teachers/get_teachers";
  static const String getTeachersDetails = "API/Teachers/teacher_info";
}
