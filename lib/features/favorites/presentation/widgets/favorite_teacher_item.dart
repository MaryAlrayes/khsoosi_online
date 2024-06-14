import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';

class FavoriteTeacherItem extends StatelessWidget {
  const FavoriteTeacherItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 1,
      child: Container(
        height: 180,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                      _buildUserImage(constraints),
                      SizedBox(
                        width: 8,
                      ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildName(),
                              SizedBox(
                                width: 4,
                              ),

                                _buildAuthenticatedIcon(),
                              SizedBox(
                                width: 4,
                              ),

                                _buildHasYoutubeVideo()
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          _buildRate()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    _buildFavorite()
                    // _buildDistance()
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                _buildTeachingType(constraints.maxWidth),
                SizedBox(
                  height: 4,
                ),
                _buildSpecialities(constraints.maxWidth),
                SizedBox(
                  height: 4,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [Expanded(child: _buildContactMe(context))],
                // )
              ],
            );
          },
        ),
      ),
    );
  }

  Icon _buildHasYoutubeVideo() {
    return Icon(
      FontAwesomeIcons.youtube,
      color: Colors.red,
      size: 14,
    );
  }

  Widget _buildRate() {
    return  CustomRating(
            initRating: 4,
            update: false,
            showRateText: true,
          );

  }

  Widget _buildContactMe(BuildContext context) {
    return CustomElevatedButton(
      label: 'تواصل معي',
      onPressed: () {
        // pushScreen(
        //   context: context,
        //   screen: TeacherDetailsScreen(
        //     teacherId: teacherEntity.id,
        //     teacherName: teacherEntity.name,
        //   ),
        // );
      },
      backgroundColor: ColorManager.black,
      icon: Icon(
        Icons.phone,
        size: 16,
      ),
    );
  }

  String _buildLocation() {
    String location = 'السعودية/ الرياض';
    // if (teacherEntity.countryAr.isNotEmpty) {
    //   location += teacherEntity.countryAr;
    //   if (teacherEntity.cityAr.isNotEmpty) {
    //     location += '/ ' + teacherEntity.cityAr;
    //   }
    // } else if (teacherEntity.countryEn.isNotEmpty) {
    //   location += teacherEntity.countryEn;
    //   if (teacherEntity.cityEn.isNotEmpty) {
    //     location += '/ ' + teacherEntity.cityEn;
    //   }
    // }
    return location;
  }

  Widget _buildTeachingType(double w) {
    List<Widget> labels = [];
    // if (teacherEntity.teachMethodInternet)
    labels.add(getOnlineChip());
    // if (teacherEntity.teachMethodOfflineByRoot) {
      labels
          .add(getFaceToFaceChip(_buildLocation(), 'SA'));
      ;
    //}
    return SizedBox(
      width: w,
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: labels,
      ),
    );
  }

  Widget _buildSpecialities(double w) {
    return SizedBox(
      width: w,
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(
          width: 4,
        ),
        itemBuilder: (context, index) =>
            _buildSpecialityItem(),
      ),
    );
  }

  Widget _buildSpecialityItem() {
    return getGrayChip(
      text:
          'رياضيات | MATH',
    );
  }

  Widget _buildAuthenticatedIcon() {
    return SvgPicture.asset(
      AppAssetsManager.authenticated,
      height: 14,
      width: 14,
      colorFilter: ColorFilter.mode(
        Colors.blue,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildName() {
    return Flexible(
      child: Text(
        "mr.geek",
        style: kBlackBoldTextStyle,
        maxLines: 1,
      ),
    );
  }
Widget _buildFavorite(){
  return IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,));
}
  Widget _buildDistance() {
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.gray2, borderRadius: BorderRadius.circular(25)),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.locationArrow,
            size: 16,
            color: Colors.green,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            '5.4 كم',
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserImage(BoxConstraints constraints) {
    return CustomImage(
      image:EndPointsManager.maleUserDefaultImageBaseUrl,
      radius: 25,
      isCircle: true,
    );
  }
}
