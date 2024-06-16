import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/institute_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/loggedin_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/login_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/signup_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/student_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_extra_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';

abstract class AccountsRepo {
  Future<Either<Failure, Unit>> signup({
    required SignupDataEntity signupDataEntity,
  });
  Future<Either<Failure, UserInfoEntity>> login(
      {required LoginDataEntity loginDataEntity});
  Future<Either<Failure, UserInfoEntity>> fetchUserInfo(
      {required String userId});

  Future<Either<Failure, Unit>> submitStudentInfo(
      {required StudentContactInfoEntity studentInfoEntity, required String userId});
  Future<Either<Failure, Unit>> uploadPicture(
      {required File image, required String userId});
  Future<Either<Failure, Unit>> activateAccount(
      {required String activationCode, required String userId});
  Future<Either<Failure, Unit>> reseubmitAcctivationCode(
      {required String userId});
  Future<Either<Failure, Unit>> submitTeacherInfo({
    required TeacherContactInfoEntity teacherInfoEntity,
    required String userId,
  });
 Future<Either<Failure, Unit>>  submitExtraTeacherInfo(
      {required TeacherExtraInfoEntity teacherExtraInfo,
      required String userId});

       Future<Either<Failure, Unit>> submitInstituteInfo({
    required InstituteContactEnitity instituteContactEnitity,
    required String userId,
  });
}
