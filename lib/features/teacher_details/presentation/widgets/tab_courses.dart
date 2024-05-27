// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/courses_services_details/presentation/courses/screens/course_details_screen.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_courses_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_course_details_screen.dart';

class TabCourses extends StatelessWidget {
  final List<TeacherCoursesEntity> courses;
  const TabCourses({
    Key? key,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: courses.isEmpty?Text('لا يوجد دورات يقدمها المدرس') :
      MasonryGridView.builder(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return _buildCourseCard(index,context);
          }),
    );
  }

  Widget _buildCourseCard(int index,BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, TeacherCourseDetailsScreen.routeName,arguments: {'id':courses[index].id});
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.black12,
        child: Container(
          height: 380,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(index),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (courses[index].isVipCourse) getSpecialCourse(),
                        _buildFavBtn(),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _buildTitle(index),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      child: _buildCategories(index),
                    ),
                    Divider(),
                    _buildOnlineOrPresent(index)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineOrPresent(int index) {
    String label = '';
    if (courses[index].presense) {
      label += 'حضوري';
    }
    if (courses[index].online) {
      label.isNotEmpty?label+='/ ':label+'';
      label += 'أونلاين';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.table,
            size: 14,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
          )
        ],
      ),
    );
  }

  ListView _buildCategories(int index) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => getGrayChip(
          text: courses[index].categories[i].nameAr +
              ' | ' +
              courses[index].categories[i].nameEn),
      separatorBuilder: (context, index) => SizedBox(
        width: 8,
      ),
      itemCount: courses[index].categories.length,
    );
  }

  Text _buildTitle(int index) {
    return Text(
      courses[index].title,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
      maxLines: 2,
    );
  }

  Icon _buildFavBtn() => Icon(Icons.favorite_border);

  Expanded _buildImage(int index) =>
      Expanded(child: CustomImage(image: courses[index].image));
}
