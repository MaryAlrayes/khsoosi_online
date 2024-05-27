
import 'package:equatable/equatable.dart';

class RateEntity extends Equatable{
  final String id;
  final String userName;
  final String date;
  final String image;
  final String comment;
  final double? rate;
  final String? voice;
  final String teacherReply;
  final String teacherName;
  final String teacherImage;
  RateEntity({
    required this.id,
    required this.userName,
    required this.date,
    required this.image,
    required this.comment,
    this.rate,
    this.voice,
    required this.teacherReply,
    required this.teacherName,
    required this.teacherImage,
  });


  @override
  List<Object?> get props => [
    id,
    userName,
    date,
    image,
    comment,
    rate,
    voice,
    teacherReply,
    teacherName,
    teacherImage,
      ];
 }
