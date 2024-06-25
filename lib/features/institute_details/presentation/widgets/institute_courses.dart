// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/courses/screens/course_details_screen.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_course_entity.dart';

class InstituteCourses extends StatelessWidget {
  final List<InstituteDetailsCourseEntity> courses;
  const InstituteCourses({
    Key? key,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.builder(
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return _buildCourseItem(context, courses[index]);
        },
      ),
    );
  }

  Widget _buildCourseItem(
      BuildContext context, InstituteDetailsCourseEntity course) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      child: Material(
        child: InkWell(
          onTap: () {
            barPushScreen(
              context: context,
              screen: CourseDetailsScreen(
                id: course.id,
              ),
            );
          },
          child: Ink(
            child: Container(
              height: 310,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _buildImage(course.image)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildCourseName(course.title),
                            SizedBox(
                              width: 4,
                            ),
                            _buildFav(),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        _buildCategories(course.categories),
                        SizedBox(
                          height: 10,
                        ),
                        _buildRating(course.rate),
                        Divider(),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDuration(course.duration),
                              SizedBox(
                                width: 4,
                              ),
                              _buildLectureNumber(
                                  context, course.lectureNumber),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomRating _buildRating(double rate) {
    return CustomRating(initRating: rate, update: false, showRateText: true);
  }

  Widget _buildImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), topLeft: Radius.circular(8)),
      child: CustomImage(
        image: image,
      ),
    );
  }

  Container _buildCategories(
      List<InstituteDetailsCourseCategoryEntity> categories) {
    return Container(
        height: 30,
        alignment: Alignment.center,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return getGrayChip(
                text: categories[index].nameAr +
                    ' | ' +
                    categories[index].nameEn);
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: categories.length,
        ));
  }

  Icon _buildFav() => Icon(Icons.favorite_border);

  Widget _buildCourseName(String name) {
    return Flexible(
      child: Text(
        name,
        style: kBlackBoldTextStyle,
        maxLines: 2,
      ),
    );
  }

  Widget _buildLectureNumber(BuildContext context, int number) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.table_chart_rounded,
            size: 16,
            color: ColorManager.orange1,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              '$number lectures',
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDuration(String duration) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            size: 16,
            color: ColorManager.red1,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              '$duration',
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
