class EndPointsManager {
  static const String baseAppUrl = "https://teacherprivate.com/";

//countries
  static const String countryImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/countries/png/48/";
  static const String countryImageExtension = '.png';

//user
  static const String userImageBaseUrl = "${baseAppUrl}assets/images/users/";
  static const String maleUserDefaultImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/male-teacher.webp";
  static const String femaleUserDefaultImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/female-teacher.webp";

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

 //portofolio Details
  static const String portofolioDetailsBaseUrl =
      "${baseAppUrl}API/Portfolio/portfolio_info?portfolio_id=";


  //institute Details
  static const String instituteDetailsBaseUrl =
      "${baseAppUrl}API/Institutes/institute_info?user_id=";


//institutes
  static const String instituteImageBaseUrl =
      "${baseAppUrl}assets/images/users/institutes/";
  static const String instituteDefaultImageBaseUrl =
      "${baseAppUrl}assets/template_files/images/logo-khsoosi.webp";

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
  static const String getInstitutesbyFilter = "API/Institutes/get_institutes";

//signup
  static const String signup = "API/Auth/signup";
//login
  static const String login = "API/Auth/login";
//user info
  static const String userInfo = "API/Users/get_general_user_info?user_id=";

//submit info
  static const String contactInfo = "API/Auth/continue_contact_profile_info";
  static const String teacherInfo = "API/Auth/continue_teacher_profile_info";
  static const String InstituteInfo =
      "API/Auth/continue_institute_profile_info";

//activate account
  static const String activateAccount = "API/Auth/activate_user";
//resend activation code
  static const String resendActivationCode =
      "API/Auth/resubmit_activation_code";

//change password
  static const String changePassword = "API/Users/change_password";

//Add location
  static const String addLocation = "API/Auth/Add_location";

//continue conditions
  static const String conditions = "API/Auth/continue_terms_conditions";

  //teacher courses
  static const String teacher_courses = "API/Courses/my_courses";

  //teacher services
  static const String teacher_services = "API/Services/my_services";

  //teacher portofolio
  static const String teacher_portofolio = "API/Portfolio/my_portfolio?user_id=";

   //teacher reviews
  static const String teacher_review = "API/Reviews/my_reviews?user_id=";

   //teacher balance
  static const String teacher_balance = "API/Users/my_balance?user_id=";

   // statistics
  static const String statistics = "API/Users/my_dashboard?user_id=";

   // notification
  static const String notification = "API/Notifications/notifications";

  // faq
  static const String faq = "API/FAQ_Articles/get_articles";
}
