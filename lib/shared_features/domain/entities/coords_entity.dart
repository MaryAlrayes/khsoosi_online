// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CoordsEntity extends Equatable{
  final double lat;
  final double lng;
  CoordsEntity({
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props =>[lat,lng];

}
