import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/comments_section.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/rates_stat.dart';

class Rates extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  Rates({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: teacherDetailsEntity.reviewEntity.isEmpty
          ? Text('لا يوجد تقييمات')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  child: RatesStat(teacherDetailsEntity: teacherDetailsEntity),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(

                    child: CommentsSection(
                     teacherDetailsEntity : teacherDetailsEntity,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
