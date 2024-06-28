import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/api_service/base_repo.dart';
import 'package:khosousi_online/core/errors/errors.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/core/utils/services/device_info_api.dart';
import 'package:khosousi_online/features/accounts/data/data_sources/accounts_data_provider.dart';
import 'package:khosousi_online/features/accounts/data/models/institute_contact_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/institute_extra_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/signup_data_model.dart';
import 'package:khosousi_online/features/accounts/data/models/student_contact_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/teacher_contact_info_model.dart';
import 'package:khosousi_online/features/accounts/data/models/teacher_extra_info_model.dart';
import 'package:khosousi_online/features/accounts/domain/entities/institute_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/institute_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/login_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/student_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/shared_features/domain/entities/university_entity.dart';

import '../../../../core/utils/services/ip_info_api.dart';
import '../../../../shared_features/data/models/university_model.dart';
import '../models/login_data_model.dart';

class AccountsRepoImpl implements AccountsRepo {
  final AccountsDataProvider accountsDataProvider;
  AccountsRepoImpl({
    required this.accountsDataProvider,
  });
  Future<Either<Failure, Unit>> signup({
    required SignupDataEntity signupDataEntity,
  }) async {
    String ip = '';
    String deviceInfo = '';
    final res = await getIPAndDeviceInfo();
    return await res.fold((f) {
      return Left(f);
    }, (res) async {
      ip += res.$1;
      deviceInfo += res.$2;
      SignupDataModel signupDataModel = SignupDataModel(
        userType: signupDataEntity.userType,
        userName: signupDataEntity.userName,
        name: signupDataEntity.name,
        email: signupDataEntity.email,
        confirmEmail: signupDataEntity.confirmEmail,
        password: signupDataEntity.password,
        confirmPassword: signupDataEntity.confirmPassword,
        isCheckedTerms: signupDataEntity.isCheckedTerms,
        ip: ip,
        deviceInfo: deviceInfo,
        serialNumber: '',
      );
      final data = await BaseRepo.repoRequest(
        request: () async {
          return await accountsDataProvider.signup(signupData: signupDataModel);
        },
      );
      return data.fold((f) => Left(f), (data) => Right(data));
    });
  }

  @override
  Future<Either<Failure, UserInfoEntity>> login(
      {required LoginDataEntity loginDataEntity}) async {
    String ip = '';
    String deviceInfo = '';
    final res = await getIPAndDeviceInfo();
    return await res.fold((f) => Left(f), (res) async {
      ip += res.$1;
      deviceInfo += res.$2;
      LoginDataModel loginDataModel = LoginDataModel(
        email: loginDataEntity.email,
        password: loginDataEntity.password,
        ip: ip,
        deviceInfo: deviceInfo,
        serialNumber: '',
      );
      final data = await BaseRepo.repoRequest(
        request: () async {
          return await accountsDataProvider.login(
              loginDataModel: loginDataModel);
        },
      );
      return data.fold((f) => Left(f), (data) => Right(data));
    });
  }

  Future<Either<Failure, (String, String)>> getIPAndDeviceInfo() async {
    String? ip = await IpInfoApi.getPublicIp();
    if (ip == null) {
      return Left(ErrorTypes.ERROR_FETCHING_IP.getFailure());
    }

    String operatingSystem = DeviceInfoApi.getOperatingSystem();
    String? operatingSystemVersion =
        await DeviceInfoApi.getOperatingSystemVersion();
    String? deviceInfo = await DeviceInfoApi.getDeviceInfo();
    if (operatingSystemVersion == null || deviceInfo == null) {
      return Left(ErrorTypes.DEVICE_INFO_ERROR.getFailure());
    }

    String deviceDetails =
        '${operatingSystem} - ${operatingSystemVersion} - ${deviceInfo}';
    print('device info: ${deviceDetails}');
    return Right((ip, deviceDetails));
  }

  @override
  Future<Either<Failure, UserInfoEntity>> fetchUserInfo(
      {required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.fetchUserInfo(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> submitStudentInfo(
      {required StudentContactInfoEntity studentInfoEntity,
      required String userId}) async {
    StudentContactInfoModel studentInfoModel = StudentContactInfoModel(
        bornDate: studentInfoEntity.bornDate,
        gender: studentInfoEntity.gender,
        mobile: studentInfoEntity.mobile,
        mobileCountry: studentInfoEntity.mobileCountry,
        countryResidence: studentInfoEntity.countryResidence,
        whatsapp: studentInfoEntity.whatsapp,
        whatsappCountry: studentInfoEntity.whatsappCountry);
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.submitContactStudentInfo(
          userId: userId,
          studentInfoModel: studentInfoModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> uploadPicture(
      {required File image, required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.uploadPicture(
            image: image, userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> activateAccount(
      {required String activationCode, required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.activateAccount(
            activationCode: activationCode, userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> reseubmitAcctivationCode(
      {required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.reseubmitAcctivationCode(
            userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> submitTeacherInfo({
    required TeacherContactInfoEntity teacherInfoEntity,
    required String userId,
  }) async {
    TeacherContactInfoModel teacherInfoModel = TeacherContactInfoModel(
        bornDate: teacherInfoEntity.bornDate,
        gender: teacherInfoEntity.gender,
        mobile: teacherInfoEntity.mobile,
        mobileCountry: teacherInfoEntity.mobileCountry,
        countryResidence: teacherInfoEntity.countryResidence,
        whatsapp: teacherInfoEntity.whatsapp,
        whatsappCountry: teacherInfoEntity.whatsappCountry,
        cityResidence: teacherInfoEntity.cityResidence,
        facebook: teacherInfoEntity.facebook,
        instagram: teacherInfoEntity.instagram,
        linkedin: teacherInfoEntity.linkedin,
        nationality: teacherInfoEntity.nationality,
        threads: teacherInfoEntity.threads,
        tiktok: teacherInfoEntity.tiktok,
        x_twitter: teacherInfoEntity.x_twitter,
        youtube: teacherInfoEntity.youtube);
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.submitContactTeacherInfo(
          teacherInfoModel: teacherInfoModel,
          userId: userId,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> submitExtraTeacherInfo({
    required TeacherExtraInfoEntity teacherExtraInfo,
    required String userId,
  }) async {
    TeacherExtraInfoModel teacherExtraInfoModel = TeacherExtraInfoModel(
      categories: teacherExtraInfo.categories,
      certificates: teacherExtraInfo.certificates,
      skills: teacherExtraInfo.skills,
      address: teacherExtraInfo.address,
      teachElementry: teacherExtraInfo.teachElementry,
      teachHouse: teacherExtraInfo.teachHouse,
      teachPreparatory: teacherExtraInfo.teachPreparatory,
      teachSecondary: teacherExtraInfo.teachSecondary,
      teachUniversity: teacherExtraInfo.teachUniversity,
      teacheOnline: teacherExtraInfo.teacheOnline,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.submitExtraTeacherInfo(
          teacherExtraInfoModel: teacherExtraInfoModel,
          userId: userId,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> submitInstituteInfo({
    required InstituteContactEnitity instituteContactEnitity,
    required String userId,
  }) async {
    InstituteContactModel instituteContactModel = InstituteContactModel(
      bornDate: instituteContactEnitity.bornDate,
      mobile: instituteContactEnitity.mobile,
      mobileCountry: instituteContactEnitity.mobileCountry,
      countryResidence: instituteContactEnitity.countryResidence,
      whatsapp: instituteContactEnitity.whatsapp,
      whatsappCountry: instituteContactEnitity.whatsappCountry,
      cityResidence: instituteContactEnitity.cityResidence,
      nationality: instituteContactEnitity.nationality,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.submitContactInstituteInfo(
          instituteContactModel: instituteContactModel,
          userId: userId,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> submitExtraInfoInstituteInfo({
    required InstituteExtraInfoEntity instituteExtraInfoEntity,
    required String userId,
  }) async {
    InstituteExtraInfoModel instituteExtraInfoModel = InstituteExtraInfoModel(
      about: instituteExtraInfoEntity.about,
      address: instituteExtraInfoEntity.address,
      name: instituteExtraInfoEntity.name,
      categories: instituteExtraInfoEntity.categories,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.submitExtraInstituteInfo(
          instituteExtraInfoModel: instituteExtraInfoModel,
          userId: userId,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> uploadCertificates(
      {required List<File> image, required String userId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.uploadCertificates(
            image: image, userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> uploadUniversities(
      {required List<UniversityEntity> universities,
      required String courses,
      required String userId}) async {
    List<UniversityModel> universitiesModel = [];
    for (int i = 0; i < universities.length; i++) {
      UniversityModel universityModel = UniversityModel(
        id: universities[i].id,
        name: universities[i].name,
      );
      universitiesModel.add(universityModel);
    }

    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.uploadUniversities(
            universities: universitiesModel, courses: courses, userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
