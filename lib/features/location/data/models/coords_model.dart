import 'package:khosousi_online/features/location/domain/entities/coords_entity.dart';

class CoordsModel extends CoordsEntity {
  CoordsModel({
    required super.lat,
    required super.lng,
  });

  Map<String, dynamic> toJson(String userId) {
    return <String, dynamic>{
      'user_id':userId,
      'latitude': lat,
      'longitude': lng,
    };
  }
}
