import 'package:khosousi_online/core/utils/enums/enums.dart';

extension SignupTypeExtension on SignupType {
  String getText() {
    switch (this) {
      case SignupType.student:
        return 'طالب';
      case SignupType.teacher:
        return 'مدرس';
      case SignupType.institute:
        return 'معهد أو مؤسسة تدريبية';
    }
  }
}

extension TeachingMethodExtension on TeachingMethod {
  String getText() {
    switch (this) {
      case TeachingMethod.presence:
        return 'حضوري';
      case TeachingMethod.online:
        return 'اونلاين/عن بعد';
    }
  }

  String getValueForApi() {
    switch (this) {
      case TeachingMethod.presence:
        return '1';
      case TeachingMethod.online:
        return '0';
    }
  }
}

extension GenderExtension on Gender {
  String getText() {
    switch (this) {
      case Gender.male:
        return 'ذكر';
      case Gender.female:
        return 'أنثى';
      case Gender.unspecified:
        return 'غير محدد';
    }
  }

  String getValueForApi() {
    switch (this) {
      case Gender.male:
        return '0';
      case Gender.female:
        return '1';
      case Gender.unspecified:
       return '';
    }
  }
}

extension EducationalLevelExtension on EducationalLevel {
  String getTextForDropDown() {
    switch (this) {
      case EducationalLevel.unspecified:
        return 'غير محدد';
      case EducationalLevel.elementry:
        return 'الابتدائية';
      case EducationalLevel.mid:
        return 'المتوسطة - الاعدادية';
      case EducationalLevel.high:
        return 'الثانوية';
      case EducationalLevel.college:
        return 'الجامعية';
    }
  }
   String getTextForDispalay() {
    switch (this) {
      case EducationalLevel.unspecified:
        return 'غير محدد';
      case EducationalLevel.elementry:
        return 'الابتدائية';
      case EducationalLevel.mid:
        return 'متوسط(إعدادي)';
      case EducationalLevel.high:
        return 'ثانوي';
      case EducationalLevel.college:
        return 'جامعي';
    }
  }

  String getValueForApi() {
    switch (this) {
      case EducationalLevel.unspecified:
        return '';
      case EducationalLevel.elementry:
        return 'elementry';
      case EducationalLevel.mid:
        return 'preparatory';
      case EducationalLevel.high:
        return 'secondary';
      case EducationalLevel.college:
        return 'university';
    }
  }
}
