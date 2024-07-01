import 'package:khosousi_online/core/utils/enums/enums.dart';

extension SignupTypeExtension on UserType {
  String getText() {
    switch (this) {
      case UserType.student:
        return 'طالب';
      case UserType.teacher:
        return 'مدرس';
      case UserType.institute:
        return 'معهد/ مركز تعليمي';
    }
  }

  String getValueForApi() {
    switch (this) {
      case UserType.student:
        return '0';
      case UserType.teacher:
        return '1';
      case UserType.institute:
        return '2';
    }
  }
}

extension TeachingMethodExtension on TeachingMethod {
  String getText() {
    switch (this) {
      case TeachingMethod.presence:
        return 'حضوري وجها لوجه';
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
      case EducationalLevel.preparatory:
        return 'المتوسطة - الاعدادية';
      case EducationalLevel.secondary:
        return 'الثانوية';
      case EducationalLevel.university:
        return 'الجامعية';
    }
  }

  String getTextForDispalay() {
    switch (this) {
      case EducationalLevel.unspecified:
        return 'غير محدد';
      case EducationalLevel.elementry:
        return 'الابتدائية';
      case EducationalLevel.preparatory:
        return 'متوسط(إعدادي)';
      case EducationalLevel.secondary:
        return 'ثانوي';
      case EducationalLevel.university:
        return 'جامعي';
    }
  }

  String getValueForApi() {
    switch (this) {
      case EducationalLevel.unspecified:
        return '';
      case EducationalLevel.elementry:
        return 'elementry';
      case EducationalLevel.preparatory:
        return 'preparatory';
      case EducationalLevel.secondary:
        return 'secondary';
      case EducationalLevel.university:
        return 'university';
    }
  }
}

extension FAQUserTypeExtension on FAQUserType {
  String getTextForDispalay() {
    switch (this) {
      case FAQUserType.student:
        return 'طالب';
      case FAQUserType.teacher:
        return 'مدرس';
      case FAQUserType.both:
        return 'مدرس وطالب';
    }
  }
}

extension SocialMediaExtension on SocialMediaType {
  String getLabelForDispalay() {
    switch (this) {
      case SocialMediaType.facebook:
        return 'Facebook';
      case SocialMediaType.instagram:
        return 'Instagram';
      case SocialMediaType.x:
        return 'منصة X';
      case SocialMediaType.youtube:
        return 'Youtube';
      case SocialMediaType.tiktok:
        return 'Tiktok';
      case SocialMediaType.threads:
        return 'Threads';
      case SocialMediaType.linkedin:
        return 'Linked In';
    }
  }

   String getHintForDispalay() {
    switch (this) {
      case SocialMediaType.facebook:
        return  'رابط حسابك على فيسبوك';
      case SocialMediaType.instagram:
        return 'رابط حسابك على انستغرام';
      case SocialMediaType.x:
        return 'رابط حسابك على X';
      case SocialMediaType.youtube:
        return 'رابط حسابك على يوتيوب';
      case SocialMediaType.tiktok:
        return 'رابط حسابك على تيكتوك';
      case SocialMediaType.threads:
        return 'رابط حسابك على Threads';
      case SocialMediaType.linkedin:
        return 'رابط حسابك على لينكد ان';
    }
  }
}

extension TeacherPhonesExtension on TeacherPhones {
  String getValueForApi() {
    switch (this) {

      case TeacherPhones.normal:
        return '1';
      case TeacherPhones.whatsapp:
         return '2';
    }
  }
}
