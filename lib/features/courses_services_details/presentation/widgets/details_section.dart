// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_category_entity.dart';

import '../../domain/entities/course_service_details_entity.dart';

class DetailsSection extends StatelessWidget {
  final CourseServiceDetailsEntity detailsEntity;
  const DetailsSection({
    Key? key,
    required this.detailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Column _buildContent() {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImage(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildName(),
                            SizedBox(
                              height: 4.h,
                            ),
                            _buildRate()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      _buildShareButton(),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
               if(!detailsEntity.presense)
               ...[  _buildLocation(),
                  SizedBox(
                    height: 16,
                  ),],
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (detailsEntity.isVip) getSpecialCourse(),
                      if (detailsEntity.lastUpdate.isNotEmpty)
                        getLastUpdateChip(detailsEntity.lastUpdate),
                      if (detailsEntity.online) getOnlineChip(),
                      if (detailsEntity.presense)
                        getFaceToFaceChip(
                          detailsEntity.country +
                              '/ ' +
                              detailsEntity.city,
                          detailsEntity.countryCode,
                        )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _buildCategories(),
                ]),
          ),
        )
      ],
    );
  }

  Row _buildShareButton() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorManager.blue1,
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          child: Icon(
            Icons.share,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
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
            detailsEntity.country + ' /' + detailsEntity.city,
            maxLines: 1,
            style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _buildCategories() {
    List<CourseServiceDetailsCategoryEntity> _data = detailsEntity.categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'التخصصات',
          style: kBlackBoldTextStyle,
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          height: 30,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => getGrayChip(
                  text: _data[index].nameAr + ' | ' + _data[index].nameEn),
              separatorBuilder: (context, index) => SizedBox(
                    width: 8,
                  ),
              itemCount: _data.length),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CustomImage(
        height: 130,
        width: double.infinity,
        image: detailsEntity.image,
      ),
    );
  }

  Row _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            detailsEntity.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
      ],
    );
  }

  Widget _buildRate() {
    // Todo: this rate is missing from API
    return CustomRating(
      initRating: 4,
      update: false,
      showRateText: true,
    );
  }
}
