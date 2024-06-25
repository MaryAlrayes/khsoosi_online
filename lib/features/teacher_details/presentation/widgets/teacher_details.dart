// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_expansion_tile.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_category_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/bloc/get_teacher_details_bloc.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/youtube_section.dart';

import '../../../../core/ui/widgets/error_widget.dart';

class TeacherDetails extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  TeacherDetails({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);
  final _popupMenu = GlobalKey<PopupMenuButtonState>();
  @override
  Widget build(BuildContext context) {
    return _buildTeacherContent();
  }

  Column _buildTeacherContent() {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (teacherDetailsEntity.youtubeBio.isNotEmpty) _buildYoutube(),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (teacherDetailsEntity.imagePath.isNotEmpty)
                      _buildImage(),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildNameAndAuthentication(),
                          SizedBox(
                            height: 4,
                          ),
                          _buildRate()
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 4,
                  runSpacing: 8,
                  children: [
                    if (teacherDetailsEntity.teachOnline) getOnlineChip(),
                    if (teacherDetailsEntity.teachPresence)
                      getFaceToFaceChip(
                        teacherDetailsEntity.residenseCountryAr +
                            '/ ' +
                            teacherDetailsEntity.residenseCityAr,
                        teacherDetailsEntity.residenseCountryCode,
                      ),
                    if (!teacherDetailsEntity.isOnline)
                      getLastUpdateChip(teacherDetailsEntity.lastDateActive),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                // _buildContactbtn(),
                // SizedBox(
                //   height: 16,
                // ),
                if (teacherDetailsEntity
                    .teacherSpecialityEntity.isNotEmpty) ...[
                  Container(
                    child: _buildCategories(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: _buildDetails(),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        )
      ],
    );
  }

  YoutubeSection _buildYoutube() {
    return YoutubeSection(
      youtube: teacherDetailsEntity.youtubeBio,
    );
  }

  Container _buildContactbtn() {
    return Container(
      width: 150,
      height: 35,
      child: PopupMenuButton(
        position: PopupMenuPosition.under,
        color: Colors.white,
        key: _popupMenu,
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 1,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.phone_enabled_sharp,
                size: 16,
              ),
              title: Text('اتصال جوال'),
            ),
            onTap: () async {},
          ),
          PopupMenuItem<int>(
            value: 1,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                FontAwesomeIcons.whatsapp,
                size: 16,
              ),
              title: Text('وتس اب whatsapp'),
            ),
            onTap: () async {},
          ),
          PopupMenuItem<int>(
            value: 1,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                FontAwesomeIcons.message,
                size: 16,
              ),
              title: Text('إرسال رسالة'),
              onTap: () async {},
            ),
            onTap: () async {},
          ),
        ],
        child: ElevatedButton.icon(
          onPressed: () async {
            _popupMenu.currentState?.showButtonMenu();
          },
          icon: Icon(
            Icons.phone,
            size: 16,
          ),
          label: Text(
            'تواصل معي',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: ColorManager.blue2),
        ),
      ),
    );
  }

  Widget _buildImage() {
    print(
      teacherDetailsEntity.imagePath,
    );
    return CustomImage(
      image: teacherDetailsEntity.imagePath,
      radius: 30,
      isCircle: true,
    );
  }

  Row _buildNameAndAuthentication() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            teacherDetailsEntity.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        if (teacherDetailsEntity.isVipAccount || teacherDetailsEntity.isSpecial)
          SvgPicture.asset(AppAssetsManager.authenticated,
              height: 16,
              width: 16,
              colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
        SizedBox(
          width: 4,
        ),
        if (teacherDetailsEntity.hasBioVideo)
          Icon(
            FontAwesomeIcons.youtube,
            color: Colors.red,
            size: 14,
          ),
        SizedBox(
          width: 4,
        ),
        if (teacherDetailsEntity.isOnline)
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
      ],
    );
  }

  Widget _buildRate() {
    return teacherDetailsEntity.averageRate != null
        ? CustomRating(
            initRating: teacherDetailsEntity.averageRate!,
            update: false,
            showRateText: true,
          )
        : Text(
            'لا يوجد تقييم',
            style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
          );
  }

  Widget _buildDetails() {
    return CustomExpansionTile(
        icon: Icon(Icons.library_books_outlined),
        title: 'تفاصيل',
        children: [
          Column(
            children: [
              _buildNationality(),
              _buildGenderAge(),
              _buildTeachingLevel(),
              _buildAddress(),
            ],
          ),
        ]);
  }

  Row _buildAddress() {
    String address = '';
    if (teacherDetailsEntity.residenseCountryAr.isNotEmpty) {
      address += teacherDetailsEntity.residenseCountryAr;
    }
    if (teacherDetailsEntity.residenseCityAr.isNotEmpty) {
      address.isNotEmpty ? address += '/ ' : '';
      address += teacherDetailsEntity.residenseCityAr;
    }
    if (teacherDetailsEntity.residenseAddress.isNotEmpty) {
      address.isNotEmpty ? address += '/ ' : '';
      address += teacherDetailsEntity.residenseAddress;
    }
    return _buildRowDetails(
        address,
        Icon(
          Icons.location_on,
          color: Colors.green,
          size: 18,
        ));
  }

  Widget _buildTeachingLevel() {
    String level = '';
    if (teacherDetailsEntity.elementary) {
      level += EducationalLevel.elementry.getTextForDispalay();
    }
    if (teacherDetailsEntity.preparatory) {
      level.isNotEmpty ? level += '/ ' : '';
      level += EducationalLevel.preparatory.getTextForDispalay();
    }
    if (teacherDetailsEntity.secondary) {
      level.isNotEmpty ? level += '/ ' : '';
      level += EducationalLevel.secondary.getTextForDispalay();
    }
    if (teacherDetailsEntity.university) {
      level.isNotEmpty ? level += '/ ' : '';
      level += EducationalLevel.university.getTextForDispalay();
    }
    return level.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildRowDetails(
                level,
                Icon(
                  FontAwesomeIcons.peopleGroup,
                  color: ColorManager.blue1,
                  size: 18,
                ),
              ),
              SizedBox(height: 12.h),
            ],
          );
  }

  Widget _buildGenderAge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRowDetails(
          '${teacherDetailsEntity.gender.getText()}/ ${teacherDetailsEntity.age}',
          Icon(
            FontAwesomeIcons.person,
            color: ColorManager.black,
            size: 18,
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildNationality() {
    String nationality = 'الجنسية: ';
    if (teacherDetailsEntity.nationalityAr.isNotEmpty)
      nationality += teacherDetailsEntity.nationalityAr;
    if (teacherDetailsEntity.nationalityEn.isNotEmpty)
      nationality += '/ ' + teacherDetailsEntity.nationalityEn;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildRowDetails(
            nationality,
            Icon(
              FontAwesomeIcons.idCard,
              color: ColorManager.black,
              size: 18,
            ),
            teacherDetailsEntity.nationalityCountryCode),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildCategories() {
    List<TeacherCategoryEntity> _data =
        teacherDetailsEntity.teacherSpecialityEntity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'الاختصاصات',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 30,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return getBlackEmptyChip(
                    text: _data[index].nameAr + ' | ' + _data[index].nameEng);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: _data.length),
        ),
      ],
    );
  }

  Row _buildRowDetails(String label, Icon icon, [String? countryImg]) {
    return Row(
      children: [
        Container(width: 40, alignment: Alignment.center, child: icon),
        SizedBox(
          width: 8.w,
        ),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              color: Colors.black,
            ),
          ),
        ),
        if (countryImg != null) ...[
          SizedBox(
            width: 8.w,
          ),
          Container(width: 20, height: 20, child: Image.network(countryImg))
        ]
      ],
    );
  }
}
