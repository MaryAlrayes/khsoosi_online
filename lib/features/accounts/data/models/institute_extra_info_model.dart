import 'package:khosousi_online/features/accounts/domain/entities/institute_extra_info_entity.dart';

class InstituteExtraInfoModel extends InstituteExtraInfoEntity {
  InstituteExtraInfoModel(
      {required super.name,
      required super.about,
      required super.address,
      required super.categories});

  Map<String, dynamic> toJson({required String userId}) {
    Map<String, dynamic> data = {
      'user_id': userId,
      'Name_en': name,
      'About': about,
      'Address': address,
    };

    for (int i = 0; i < categories.length; i++) {
      data['User_category[${i + 1}]'] = categories[i].id;
    }
    return data;
  }
}
