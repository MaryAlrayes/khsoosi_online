// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';
// import 'package:khosousi_online/features/accounts/domain/entities/loggedin_data_entity.dart';

// class LoggedInDataModel extends LoggedInDataEntity {

//   LoggedInDataModel({
//     required super.userId,
//     required super.name,
//     required super.email,
//     required super.type,
//     required super.isActive,
//     required super.isEnabled,
//     required super.isConditionAgreed,
//     required super.isLoggedIn,
//   });
//   factory LoggedInDataModel.fromJson(Map<String, dynamic> map) {
//     return LoggedInDataModel(
//       userId: map['id'] as String,
//       name: map['name'] as String,
//       email: map['email'] as String,
//       type: map['type'] as String,
//       isActive: map['Is_active'] =='1',
//       isEnabled: map['Is_enabled'] =='1',
//       isConditionAgreed: map['Is_conditions_agreed'] =='1',
//       isLoggedIn: map['is_logged_in'] ==1,
//     );
//   }

// Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'id': userId,
//       'name': name,
//       'email': email,
//       'type': type,
//       'Is_active': isActive?'1':'0',
//       'Is_enabled': isEnabled?'1':'0',
//       'Is_conditions_agreed': isConditionAgreed?'1':'0',
//       'is_logged_in': isLoggedIn?1:0,
//     };
//   }

// }
