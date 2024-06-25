// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/search/domain/entities/course_entity.dart';

import '../../../../courses_services_portofolio_details/presentation/courses/screens/course_details_screen.dart';

class CourseItem extends StatelessWidget {
  final CourseEntity courseEntity;
  const CourseItem({
    Key? key,
    required this.courseEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      child: Material(
        child: InkWell(
          onTap: () {
            barPushScreen(
              context: context,
              screen: CourseDetailsScreen(
                id: courseEntity.id,
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
                  Expanded(child: _buildImage()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (courseEntity.isVipCourse) _buildSpecialCourse(),
                            SizedBox(
                              width: 4,
                            ),
                            _buildFav(),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        _buildCourseName(),
                        SizedBox(
                          height: 8,
                        ),
                        _buildCategories(),
                          SizedBox(
                          height: 10,
                        ),
                        Divider(),

                        Container(
                          width: double.infinity,
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildLocation(),
                              SizedBox(
                                width: 4,
                              ),
                              _buildCourseProvider(context),
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

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), topLeft: Radius.circular(8)),
      child: CustomImage(
        image: courseEntity.imagePath,
      ),
    );
  }

  Container _buildCategories() {
    return Container(
        height: 30,
        alignment: Alignment.center,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return getGrayChip(
                text: courseEntity.categories[index].nameAr +
                    ' | ' +
                    courseEntity.categories[index].nameEng);
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: courseEntity.categories.length,
        ));
  }

  Widget _buildSpecialCourse() {
    return getSpecialCourse();
  }

  Icon _buildFav() => Icon(Icons.favorite_border);

  Text _buildCourseName() {
    return Text(
      courseEntity.title,
      style: kBlackBoldTextStyle,
      maxLines: 2,
    );
  }

  Widget _buildCourseProvider(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
      barPushScreen(context: context, screen: CourseDetailsScreen(id: courseEntity.publisherUserId));
      },
      icon: Icon(
        Icons.person,
        size: 16,
        color: ColorManager.orange1,
      ),
      label: Text(
        'مقدم الدورة',
        style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
        overflow: TextOverflow.ellipsis,
      ),

      style: TextButton.styleFrom(
        foregroundColor: Colors.black,

      ),

    );
    // return Flexible(
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Icon(
    //         Icons.person,
    //         size: 16,
    //         color: ColorManager.orange1,
    //       ),
    //       SizedBox(
    //         width: 8,
    //       ),
    //       Flexible(
    //         child: Text(
    //           'مقدم الدورة',
    //           maxLines: 1,
    //           style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _buildLocation() {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            size: 16,
            color: ColorManager.green1,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              courseEntity.countryAr + ' /' + courseEntity.cityAr,
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
