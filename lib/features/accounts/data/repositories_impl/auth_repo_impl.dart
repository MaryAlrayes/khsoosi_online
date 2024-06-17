import 'package:khosousi_online/features/accounts/data/models/loggedin_data_model.dart';
import 'package:khosousi_online/features/accounts/data/models/user_info_model.dart';
import 'package:khosousi_online/features/accounts/domain/entities/loggedin_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

import '../../../../core/utils/services/shared_preferences.dart';

class AuthRepoImpl extends AuthRepo {
  static const _UserInfoKey = 'userInfo';
  @override
  Future<bool> deleteUserInfo() async {
    return await PreferenceUtils.removeValue(_UserInfoKey);
  }

  @override
  UserInfoEntity? getUserInfo() {
    dynamic data = PreferenceUtils.getObject(_UserInfoKey);
    if (data == null) {
      return null;
    }
    Map<String, dynamic> mappedData = data as Map<String, dynamic>;

    UserInfoEntity userEntity = UserInfoModel.fromJson(mappedData);
    return userEntity;
  }

  @override
  Future<bool> hasUserInfo() {
    return PreferenceUtils.hasValue(_UserInfoKey);
  }

  @override
  Future<void> saveUserInfo(UserInfoEntity user) async {
    await PreferenceUtils.setObject(
        _UserInfoKey, (user as UserInfoModel).toJson());
  }

  @override
  String? getUserId() {
    final UserInfoEntity? userInfo = getUserInfo();
    if (userInfo != null) {
      return userInfo.userId;
    } else {
      return null;
    }
  }

  @override
  String? getName() {
    final UserInfoEntity? userInfo = getUserInfo();
    if (userInfo != null) {
      return userInfo.name;
    } else {
      return null;
    }
  }

  @override
  String? getUserName() {
    final UserInfoEntity? userInfo = getUserInfo();
    if (userInfo != null) {
      return userInfo.userName;
    } else {
      return null;
    }
  }

  @override
  bool isActive() {
    final UserInfoEntity? userInfo = getUserInfo();
    if (userInfo != null) {
      return userInfo.isActive;
    } else {
      return false;
    }
  }

  @override
  Future<void> updateActiveState() async {
    UserInfoModel currentData = getUserInfo() as UserInfoModel;
    UserInfoModel newData = currentData.copyWith(isActive: true);
    saveUserInfo(newData);
  }

  @override
  Future<void> updateHasFinishedInfoState() async {
    UserInfoModel currentData = getUserInfo() as UserInfoModel;
    UserInfoModel newData = currentData.copyWith(isEnabled: true);
    saveUserInfo(newData);
  }

  @override
  Future<void> updateLocationState(
      {required double lat, required double lng}) async {
    UserInfoModel currentData = getUserInfo() as UserInfoModel;
    UserInfoModel newData = currentData.copyWith(lat: lat, lng: lng);
    saveUserInfo(newData);
  }
}
