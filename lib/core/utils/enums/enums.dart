enum SignupType{
  student,
  teacher,
  institute
}

enum SearchType{
  teachers,
  courses,
  institutes,
  services
}

enum SearchTeacherSteps {
  teachingMethod,
  location,
  educationalLevel,
  speciality,
  gender,
  keyword,
  result
}

enum Gender {
  male,
  female,
  unspecified
}

enum TeachingMethod { presence, online }

enum EducationalLevel { unspecified, elementry, mid, high, college }

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

enum LocationType{
  nearestTeacher,
  chooseCountey
}
