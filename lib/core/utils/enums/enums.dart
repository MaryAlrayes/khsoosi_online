enum UserType { student, teacher, institute }

enum SignupSteps { userType, name, emailPassword }

enum SearchType { teachers, courses, institutes, services }

enum SearchTeacherSteps {
  teachingMethod,
  location,
  educationalLevel,
  speciality,
  gender,
  keyword,
  result
}

enum Gender { male, female, unspecified }

enum TeachingMethod { presence, online }

enum EducationalLevel {
  unspecified,
  elementry,
  preparatory,
  secondary,
  university
}

enum SearchCoursesSteps {
  teachingMethod,
  location,
  educationalLevel,
  speciality,
  gender,
  keyword,
  result
}

enum SearchInstitutesSteps {
  location,

  speciality,

  result
}

enum SearchServicesSteps {
  location,

  keyword,

  result
}

enum LocationType { nearestTeacher, chooseCountey }

enum FAQUserType { student, teacher, both }

enum SupportMessageUser{me,support}

enum SocialMediaType{
  facebook,
  instagram,
  x,
  youtube,
  tiktok,
  threads,
  linkedin
}

enum TeacherPhones{
  normal,
  whatsapp
}
