class EndPointsManager {
  static const String baseAppUrl = "https://teacherprivate.com/";

//countries
  static const String countryImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/countries/png/48/";
  static const String countryImageExtension = '.png';

//user
  static const String userImageBaseUrl = "${baseAppUrl}assets/images/users/";
static const String maleUserDefaultImageBaseUrl = "${baseAppUrl}assets/template_files/images/male-teacher.webp";
static const String femaleUserDefaultImageBaseUrl = "${baseAppUrl}assets/template_files/images/female-teacher.webp";

  //certificates
  static const String certificateImageBaseUrl =
      "${baseAppUrl}assets/images/users/portfolios/";
  static const String certificateDefaultImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/logo-khsoosi.webp";

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

//course Details
static const String courseDetailsBaseUrl =
      "${baseAppUrl}API/Courses/course_info?course_id=";

      //service Details
static const String serviceDetailsBaseUrl =
      "${baseAppUrl}API/Services/service_info?service_id=";

  static const String getCategories = "users/get_categories_tags";
  static const String getCountries = "countries/get_all_countries";
  static const String getCities = "countries/get_cities_by_country_api";

//get teachers
  static const String getAllTeachers = "Teachers/get_all_teachers_api";
  static const String getTeachersbyFilter = "API/Teachers/get_teachers";
  static const String getTeachersDetails = "API/Teachers/teacher_info";

//get courses
  static const String getCoursesbyFilter = "API/Courses/get_courses";

//get services
  static const String getServicesbyFilter = "API/Services/get_services";

  //get institutes
  static const String getInstitutesbyFilter = "Institutes/get_all_institutes_api";

//signup
static const String signup = "API/Auth/signup";
//login
static const String login = "API/Auth/login";
//user info
static const String userInfo = "API/Users/get_general_user_info?user_id=";

//submit info
static const String contactInfo = "API/Auth/continue_contact_profile_info";
static const String teacherInfo = "API/Auth/continue_teacher_profile_info";

//activate account
static const String activateAccount = "API/Auth/activate_user";
//resend activation code
static const String resendActivationCode = "API/Auth/resubmit_activation_code";

//change password
static const String changePassword = "API/Users/change_password";

}
