enum UserType { student, teacher, institute }

enum SignupSteps { userType, name, emailPassword }

enum StudentInfoStepperSteps {
  phones,
  general,
  picture,
}

enum TeacherInfoStepperSteps {
  phones,
  general,
  social_media,
  teachingMethod,
  educationalLevel,
  address,
  categories,
  certificates,
  skills,
  location,
  picture,
}

enum InstituteInfoStepperSteps {
  phones,
  general,
  nameAboutAddress,
  categories,
  location,
  picture,
}

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
enum FAQUserType{
  student,
  teacher,both
}
