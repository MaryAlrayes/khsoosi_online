// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/widgets/main_details_content.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_details_screen.dart';

import '../../domain/entities/course_service_details_teacher_entity.dart';

class TabInstructor extends StatelessWidget {
  final CourseServiceDetailsTeacherEntity teacher;
  final DetailsType detailsType;
  const TabInstructor({
    Key? key,
    required this.teacher,
    required this.detailsType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(constraints),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildName(),
                            SizedBox(
                              height: 4,
                            ),
                            _buildUserName(),
                            SizedBox(
                              height: 6,
                            ),
                            _builContactTeacher(context)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              _buildServicesCoursesNumber(),
              SizedBox(
                height: 8,
              ),
              _buildTeachingType(),
              SizedBox(
                height: 8,
              ),
              _buildRate(),
              SizedBox(
                height: 16,
              ),
              _buildInstructorDetails()
            ],
          ),
        ),
      ),
    );
  }

  Row _buildServicesCoursesNumber() {
    String _number = '';
    if (detailsType == DetailsType.course) {
      _number += '${teacher.coursesNumber} دورة';
    }
    if (detailsType == DetailsType.service) {
      _number += '${teacher.coursesNumber} خدمة';
    }
    return _buildRow(
        text: _number,
        icon: Icon(
          FontAwesomeIcons.noteSticky,
          size: 16,
          color: ColorManager.red1,
        ),
        backgroundColor: ColorManager.lightRed);
  }

  Row _buildTeachingType() {
    String teachingType = '';
    if (teacher.teachOnline) {
      teachingType += 'تدريس عن بعد';
    }
    if (teacher.teachPresence) {
      if (teachingType.isNotEmpty) teachingType += ' /';
      teachingType += 'تدريس حضوري وجها لوجه';
    }
    return _buildRow(
        text: teachingType,
        icon: Icon(
          FontAwesomeIcons.chalkboardUser,
          size: 16,
          color: ColorManager.orange,
        ),
        backgroundColor: ColorManager.lightOrange);
  }

  Row _buildRate() {
    String rate = '';
    if (teacher.teacherRate == null) {
      rate = '(لا يوجد تقييم)';
    } else {
      rate = '${teacher.teacherRate}/5';
    }
    return _buildRow(
        text: 'متوسط التقييمات $rate',
        icon: Icon(
          FontAwesomeIcons.solidStar,
          size: 16,
          color: ColorManager.darkYellow,
        ),
        backgroundColor: ColorManager.lightYellow);
  }

  CustomChipItem _builContactTeacher(BuildContext context) {
    return CustomChipItem(
      label: 'تواصل مع المدرب',
      backgroundColor: ColorManager.green1,
      foregroundColor: Colors.white,
      iconData: Icons.phone,
      onPressed: () {
        print('teacher id ${teacher.teacherId}');
        Navigator.pushNamed(
          context,
          TeacherDetailsScreen.routeName,
          arguments: {'id': teacher.teacherId},
        );
      },
    );
  }

  Flexible _buildUserName() {
    return Flexible(
      child: Text(
        teacher.userName,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Flexible _buildName() {
    return Flexible(
      child: Text(
        teacher.name,
        style: kBlackBoldTextStyle,
      ),
    );
  }

  Row _buildRow(
      {required String text,
      required Icon icon,
      required Color backgroundColor}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor,
          child: icon,
          radius: 28,
        ),
        SizedBox(
          width: 16,
        ),
        Flexible(
            child: Text(
          text,
          style: TextStyle(fontSize: 12),
        )),
      ],
    );
  }

  Widget _buildInstructorDetails() {
    return Column(
      children: [

        CustomReadMoreText(
          text: CustomHtmlParser.parseHtml(teacher.description)+'\n'+ CustomHtmlParser.parseHtml(teacher.certifications),
          trimLines: 3,
        ),
      ],
    );
  }

  Widget _buildImage(BoxConstraints constraints) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CustomImage(
        width: constraints.minWidth / 3,
        image: teacher.imagePath,
      ),
    );
  }
}
