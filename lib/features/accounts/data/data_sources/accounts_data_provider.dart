import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_api_service.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/features/accounts/data/models/institute_contact_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/institute_extra_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/login_data_model.dart';
import 'package:khosousi_online/features/accounts/data/models/signup_data_model.dart';
import 'package:khosousi_online/features/accounts/data/models/student_contact_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/teacher_extra_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/user_info_model.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';

import '../../../../shared_features/data/models/university_model.dart';
import '../../../../shared_features/domain/entities/university_entity.dart';
import '../models/loggedin_data_model.dart';
import '../models/teacher_contact_info_model.dart';

abstract class AccountsDataProvider {
  Future<Unit> signup({required SignupDataModel signupData});
  Future<UserInfoModel> login({required LoginDataModel loginDataModel});
  Future<UserInfoModel> fetchUserInfo({required String userId});

  Future<Unit> uploadPicture({required File image, required String userId});

  Future<Unit> activateAccount(
      {required String activationCode, required String userId});
  Future<Unit> reseubmitAcctivationCode({required String userId});
  Future<Unit> submitContactStudentInfo(
      {required StudentContactInfoModel studentInfoModel,
      required String userId});
  Future<Unit> submitContactTeacherInfo(
      {required TeacherContactInfoModel teacherInfoModel,
      required String userId});
  Future<Unit> submitExtraTeacherInfo(
      {required TeacherExtraInfoModel teacherExtraInfoModel,
      required String userId});
  Future<Unit> submitContactInstituteInfo(
      {required InstituteContactModel instituteContactModel,
      required String userId});
  Future<Unit> submitExtraInstituteInfo(
      {required InstituteExtraInfoModel instituteExtraInfoModel,
      required String userId});

  Future<Unit> uploadCertificates(
      {required List<File> image, required String userId});
  Future<Unit> uploadUniversities(
      {required List<UniversityModel> universities,required String courses, required String userId});
}

class AccountsDataProviderWithDio implements AccountsDataProvider {
  final BaseApiService client;
  AccountsDataProviderWithDio({
    required this.client,
  });
  @override
  Future<Unit> signup({
    required SignupDataModel signupData,
  }) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.signup,
      jsonBody: signupData.toJson(),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if (errors[e].isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<UserInfoModel> login({required LoginDataModel loginDataModel}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.login,
      jsonBody: loginDataModel.toJson(),
    );
    if (res['status'] == true) {
      return UserInfoModel.fromJson(res);
    } else {
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }

  @override
  Future<UserInfoModel> fetchUserInfo({required String userId}) async {
    final res = await client.getRequest(
      url: EndPointsManager.userInfo + '$userId',
    );
    return UserInfoModel.fromJson(res['user_info']);
  }

  @override
  Future<Unit> submitContactStudentInfo(
      {required StudentContactInfoModel studentInfoModel,
      required String userId}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.contactInfo,
      jsonBody: studentInfoModel.toJson(userId: userId),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'];

      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if (errors[e].isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<Unit> uploadPicture(
      {required File image, required String userId}) async {
    return Future.delayed(
      Duration(seconds: 5),
      () {
        return unit;
      },
    );
  }

  @override
  Future<Unit> activateAccount({
    required String activationCode,
    required String userId,
  }) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.activateAccount,
      jsonBody: {
        'user_id': userId,
        'activation_code': activationCode,
      },
    );
    if (res['status'] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(
        message: res['error messages'],
      );
    }
  }

  @override
  Future<Unit> reseubmitAcctivationCode({required String userId}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.resendActivationCode,
      jsonBody: {
        'user_id': userId,
      },
    );
    if (res['status'] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(
        message: res['error messages'],
      );
    }
  }

  @override
  Future<Unit> submitContactTeacherInfo({
    required TeacherContactInfoModel teacherInfoModel,
    required String userId,
  }) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.contactInfo,
      jsonBody: teacherInfoModel.toJson(userId: userId),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if (errors[e].isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<Unit> submitExtraTeacherInfo({
    required TeacherExtraInfoModel teacherExtraInfoModel,
    required String userId,
  }) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.teacherInfo,
      jsonBody: teacherExtraInfoModel.toJson(userId: userId),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if (errors[e].isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<Unit> submitContactInstituteInfo(
      {required InstituteContactModel instituteContactModel,
      required String userId}) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.contactInfo,
      jsonBody: instituteContactModel.toJson(userId: userId),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if (errors[e].isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<Unit> submitExtraInstituteInfo({
    required InstituteExtraInfoModel instituteExtraInfoModel,
    required String userId,
  }) async {
    final res = await client.multipartRequest(
      url: EndPointsManager.InstituteInfo,
      jsonBody: instituteExtraInfoModel.toJson(userId: userId),
    );
    if (res['status'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['error messages'];

      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if (errors[e].isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<Unit> uploadCertificates({
    required List<File> image,
    required String userId,
  }) async {
    return Future.delayed(
      Duration(seconds: 5),
      () {
        return unit;
      },
    );
  }

  @override
  Future<Unit> uploadUniversities({required List<UniversityModel> universities, required String courses, required String userId})async {
   return Future.delayed(
      Duration(seconds: 5),
      () {
        return unit;
      },
    );
  }
}
