import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

class FavoriteCoursesItem extends StatelessWidget {
  const FavoriteCoursesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      child: Material(
        child: InkWell(
          onTap: () {
            // pushScreen(
            //   context: context,
            //   screen: CourseDetailsScreen(
            //     id: courseEntity.id,
            //   ),
            // );
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
        image: EndPointsManager.coursesDefaultImageBaseUrl,
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
            return getGrayChip(text: 'رياضيات' + ' | ' + 'Math');
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: 10,
        ));
  }

  Widget _buildSpecialCourse() {
    return getSpecialCourse();
  }

  Widget _buildFav() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ));
  }

  Text _buildCourseName() {
    return Text(
      'اسم الدورة',
      style: kBlackBoldTextStyle,
      maxLines: 2,
    );
  }

  Widget _buildCourseProvider(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // pushScreen(
        //     context: context,
        //     screen: CourseDetailsScreen(id: courseEntity.publisherUserId));
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
              'السعودية' + ' /' + 'الرياض',
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
