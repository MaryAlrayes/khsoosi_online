import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';

abstract class AuthRepo {
  //save user info
  Future<void> saveUserInfo(UserInfoEntity user);
  //get user info
  UserInfoEntity? getUserInfo();
  //is there user info
  Future<bool> hasUserInfo();
  //delete user info
  Future<bool> deleteUserInfo();
  //update the isActive attribute state when the user verifies his account using otp
  Future<void> updateActiveState();
  // update the isEnable attribute when the user adds his info in registration step
  Future<void> updateHasFinishedInfoState();
  // update the lat and lng when the user changes his location
  Future<void> updateLocationState({required double lat, required double lng});
  // update the isAgreed attrinute when the user agrees or disagrees the conditions
  Future<void> updateConditionsState({required bool answer});

  //get user id
  String? getUserId();
  //get name
  String? getName();
  //get user name
  String? getUserName();
  //has the use activated his account using otp or not
  bool isActive();
}
//
