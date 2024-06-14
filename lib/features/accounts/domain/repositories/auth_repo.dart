import 'package:khosousi_online/features/accounts/domain/entities/loggedin_data_entity.dart';
import 'package:khosousi_online/features/accounts/domain/entities/user_info_entity.dart';

abstract class AuthRepo {
  Future<void> saveUserInfo(UserInfoEntity user);
  UserInfoEntity? getUserInfo();
  Future<bool> hasUserInfo();
  Future<bool> deleteUserInfo();
  Future<void> updateActiveState();
  Future<void> updateHasFinishedInfoState();


  String? getUserId();
  String? getName();
  String? getUserName();
  bool isActive();
}
