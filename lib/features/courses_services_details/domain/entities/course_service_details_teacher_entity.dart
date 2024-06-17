
import 'package:equatable/equatable.dart';

class CourseServiceDetailsTeacherEntity extends Equatable {
  final String teacherId;
  final String name;
  final String userName;
  final String imagePath;
  final bool teachOnline;
  final bool teachPresence;
  final double? teacherRate;
  final int coursesNumber;
  final String description;
  final String certifications;
  CourseServiceDetailsTeacherEntity({
    required this.teacherId,
    required this.name,
    required this.userName,
    required this.imagePath,
    required this.teachOnline,
    required this.teachPresence,
    required this.teacherRate,
    required this.coursesNumber,
    required this.description,
    required this.certifications,
  });

  @override
  List<Object?> get props => [
    teacherId,
    name,
    userName,
    imagePath,
    teachOnline,
    teachPresence,
    teacherRate,
    coursesNumber,
    description,
    certifications
  ];





 }
