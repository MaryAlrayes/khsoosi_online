import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../courses_details/presentation/screens/course_details_screen.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      child: Material(
        child: InkWell(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: CourseDetailsScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.slideUp,
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
                            _buildSpecialCourse(),
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
                        Divider(),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildLocation(),
                              SizedBox(
                                width: 4,
                              ),
                              _buildCourseProvider(),
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
        image:
            'https://st2.depositphotos.com/1350793/8224/i/450/depositphotos_82249918-stock-photo-hand-pressing-an-online-course.jpg',
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
            return getGrayChip(text: 'علوم');
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: 5,
        ));
  }

  Widget _buildSpecialCourse() {
    return getSpecialCourse();
  }

  Icon _buildFav() => Icon(Icons.favorite_border);

  Text _buildCourseName() {
    return Text(
      'دورة في مادة العلوم للمرحلة الثانوية',
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
      maxLines: 2,
    );
  }

  Widget _buildCourseProvider() {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            size: 16,
            color: ColorManager.orange1,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(
              'مقدم الدورة',
              maxLines: 1,
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
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
              'سوريا/دمشق',
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
