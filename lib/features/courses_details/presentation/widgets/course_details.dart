import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key});

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
                      Row(
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
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      getSpecialCourse(),
                      // getLastUpdate(DateTime.now()),
                      getOnlineChip(),
                      getFaceToFaceChip(
                        'السعودية/جدة',
                        EndPointsManager.countryImageBaseUrl + 'SA' + '.webp',
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

  Widget _buildLocation() {
    return Row(
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
            'السعودية / الرياض',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _buildCategories() {
    List<String> _data = [
      'وورد | ms Word',
      'ويندوز | Windows',
      'برامج اوفيس | ms Office',
      'اكسل | ms Excel',
      'حاسب الي | Computer',
    ];
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
              itemBuilder: (context, index) => getGrayChip(text: _data[index]),
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
        image:
            'https://st2.depositphotos.com/1350793/8224/i/450/depositphotos_82249918-stock-photo-hand-pressing-an-online-course.jpg',
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
            'مهارات الحاسب الالي',
            style: TextStyle(
              fontSize: 20,
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
    return CustomRating(
      initRating: 4,
      update: false,
      showRateText: true,
    );
  }
}
