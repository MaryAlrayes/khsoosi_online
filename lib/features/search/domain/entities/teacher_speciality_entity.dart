
import 'package:equatable/equatable.dart';

class TeacherSpecialityEntity extends Equatable {
  final String id;
  final String nameAr;
  final String nameEng;
  TeacherSpecialityEntity({
    required this.id,
    required this.nameAr,
    required this.nameEng,
  });

  @override
  List<Object?> get props =>[
    id,
    nameAr,
    nameEng,
  ];
}
