import 'package:khosousi_online/core/utils/enums/enums.dart';
class UserTypeSelection{
static UserType getUserType(String type) {
  switch (type) {
    case '0':
      return UserType.student;
    case '1':
      return UserType.teacher;
    case '2':
      return UserType.institute;
    default:
      return UserType.student;
  }
}
}
