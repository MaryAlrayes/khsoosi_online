// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_category_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/teacher_details_screen.dart';


class TeacherItem extends StatelessWidget {
  final TeacherEntity teacherEntity;
  const TeacherItem({
    Key? key,
    required this.teacherEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 240,
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
                    if (teacherEntity.imagePath.isNotEmpty) ...[
                      _buildUserImage(constraints),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildName(),
                              SizedBox(
                                width: 4,
                              ),
                              if (teacherEntity.isSpecial ||
                                  teacherEntity.isVipAccount)
                                _buildAuthenticatedIcon(),
                              SizedBox(
                                width: 4,
                              ),
                              if (teacherEntity.hasBioVideo)
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
                 if(teacherEntity.distance!=null)   _buildDistance()
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Expanded(child: _buildContactMe(context))],
                )
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
    return teacherEntity.average != null
        ? CustomRating(
            initRating: teacherEntity.average!,
            update: false,
            showRateText: true,
          )
        : Text(
            'لا يوجد تقييم',
            style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
          );
  }

  Widget _buildContactMe(BuildContext context) {
    return CustomElevatedButton(
      label: 'تواصل معي',
      onPressed: () {
        barPushScreen(
          context: context,
          screen: TeacherDetailsScreen(
            teacherId: teacherEntity.id,
            teacherName: teacherEntity.name,
          ),
        );
      },
      backgroundColor: ColorManager.black,
      icon: Icon(
        Icons.phone,
        size: 16,
      ),
    );
  }

  String _buildLocation() {
    String location = '';
    if (teacherEntity.countryAr.isNotEmpty) {
      location += teacherEntity.countryAr;
      if (teacherEntity.cityAr.isNotEmpty) {
        location += '/ ' + teacherEntity.cityAr;
      }
    } else if (teacherEntity.countryEn.isNotEmpty) {
      location += teacherEntity.countryEn;
      if (teacherEntity.cityEn.isNotEmpty) {
        location += '/ ' + teacherEntity.cityEn;
      }
    }
    return location;
  }

  Widget _buildTeachingType(double w) {
    List<Widget> labels = [];
    if (teacherEntity.teachMethodInternet) labels.add(getOnlineChip());
    if (teacherEntity.teachMethodOfflineByRoot) {
      labels
          .add(getFaceToFaceChip(_buildLocation(), teacherEntity.countryCode));
      ;
    }
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
        itemCount: teacherEntity.teacherSpecialityEntity.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 4,
        ),
        itemBuilder: (context, index) =>
            _buildSpecialityItem(teacherEntity.teacherSpecialityEntity[index]),
      ),
    );
  }

  Widget _buildSpecialityItem(TeacherCategoryEntity teacherSpecialityEntity) {
    return getGrayChip(
      text:
          '${teacherSpecialityEntity.nameAr} | ${teacherSpecialityEntity.nameEng}',
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
        teacherEntity.name,
        style: kBlackBoldTextStyle,
        maxLines: 1,
      ),
    );
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
            '${teacherEntity.distance!.toStringAsFixed(1)} كم',
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
      image: teacherEntity.imagePath,
      radius: 25,
      isCircle: true,
    );
  }
}
