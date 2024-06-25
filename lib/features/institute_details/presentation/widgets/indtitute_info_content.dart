// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

import '../../../../core/utils/helpers/html_parser.dart';
import '../../domain/entities/institute_details_entity.dart';

class InstituteInfoContent extends StatelessWidget {
    final InstituteDetailsEntity instituteDetailsEntity;
  const InstituteInfoContent({
    Key? key,
    required this.instituteDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImage(constraints),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildName(),
                          SizedBox(
                            height: 4,
                          ),
                          _buildSubtitle(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              _buildDescription(),
              SizedBox(
                height: 24,
              ),
              _buildLocation(),
              SizedBox(
                height: 8,
              ),
              _buildAddress(),
              SizedBox(
                height: 8,
              ),
              _buildEmail(),
              SizedBox(
                height: 8,
              ),
              _buildPhone(),
              SizedBox(
                height: 8,
              ),
              _buildWhatsup(),
              SizedBox(
                height: 16,
              ),
              _buildStatList(),
              SizedBox(
                height: 16,
              ),
              _buildCategories(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhatsup() {
    return _buildRow(
      icon: Icon(
        FontAwesomeIcons.whatsapp,
        size: 16,
      ),
      label: 'الواتساب',
      valueWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildShowNumberBtn(),
        ],
      ),
    );
  }

  Widget _buildPhone() {
    return _buildRow(
      icon: Icon(
        FontAwesomeIcons.phone,
        size: 16,
      ),
      label: 'الجوال',
      valueWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildShowNumberBtn(),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return _buildRow(
      icon: Icon(
        FontAwesomeIcons.envelope,
        size: 16,
      ),
      label: 'الايميل',
      valueWidget: Text(
       instituteDetailsEntity.email,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildAddress() {
    return _buildRow(
        icon: Icon(
          FontAwesomeIcons.globe,
          size: 16,
        ),
        label: 'العنوان',
        valueWidget: Text(
         CustomHtmlParser.parseHtml( instituteDetailsEntity.address),
          style: TextStyle(fontSize: 12),
        ));
  }

  Widget _buildLocation() {
    String location = '';
    if (instituteDetailsEntity.country .isNotEmpty)
      location += instituteDetailsEntity.country;
    if (instituteDetailsEntity.city.isNotEmpty)
      location += '/ ' + instituteDetailsEntity.city;

    return _buildRow(
      icon: Icon(
        Icons.location_pin,
        size: 18,
      ),
      label: 'الموقع',
      valueWidget: Row(
        children: [
          Container(
              width: 20,
              height: 20,
              child: Image.network(EndPointsManager.countryImageBaseUrl +
                  '${instituteDetailsEntity.countryImageCode}' +
                  EndPointsManager.countryImageExtension)),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            '${location}',
            style: TextStyle(fontSize: 12),
          ))
        ],
      ),
    );
  }

  SizedBox _buildShowNumberBtn() {
    return SizedBox(
      height: 30,
      child: CustomElevatedButton(
        label: 'إظهار الرقم',
        onPressed: () {},
        backgroundColor: ColorManager.black,
      ),
    );
  }

  Widget _buildRow(
      {required Icon icon,
      required String label,
      required Widget valueWidget}) {
    return Row(
      children: [
        Container(width: 40, alignment: Alignment.center, child: icon),
        SizedBox(
          width: 4,
        ),
        Flexible(
          child: Row(
            children: [
              Text(
                '$label: ',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(child: valueWidget),
            ],
          ),
        ),
      ],
    );
  }

  Text _buildDescription() {
    return Text(
     CustomHtmlParser.parseHtml( instituteDetailsEntity.description),

      style: TextStyle(fontSize: 12),
    );
  }

  Text _buildSubtitle() {
    return Text(
      instituteDetailsEntity.job,
      style: TextStyle(fontSize: 12),
    );
  }

  Widget _buildName() {
    return Flexible(
      child: Text(
        instituteDetailsEntity.name,
        style: kBlackBoldTextStyle,
      ),
    );
  }

  ClipRRect _buildImage(BoxConstraints constraints) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CustomImage(
        width: constraints.maxWidth / 3,
        height: constraints.maxWidth / 3,
        image: instituteDetailsEntity.image,
        isCircle: false,
      ),
    );
  }

  SizedBox _buildStatList() {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStatCard(
              icon: Icon(
                Icons.note,
                color: Color(0xff0CBC87),
              ),
              label: 'اجمالي الدورات',
              value: instituteDetailsEntity.coursesNumber.toString(),
              backgroundColor: Color(0xffE6F8F3)),
          SizedBox(
            width: 16,
          ),
          _buildStatCard(
              icon: Icon(
                Icons.people,
                color: Color(0xff6F42C1),
              ),
              label: 'المراحل التي يدرّسها',
              value: instituteDetailsEntity.numberOfStages .toString(),
              backgroundColor: Color(0xffF0ECF9)),
          SizedBox(
            width: 16,
          ),
          _buildStatCard(
              icon: Icon(
                FontAwesomeIcons.chalkboardUser,
                color: Color(0xffFD7E14),
              ),
              label: 'طريقة التدريس',
              value: instituteDetailsEntity.eductaionalMethod.toString(),
              backgroundColor: Color(0xffFFF2E7))
        ],
      ),
    );
  }

  Row _buildStatCard(
      {required Icon icon,
      required String label,
      required String value,
      required Color backgroundColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: icon,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '+$value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12),
            )
          ],
        )
      ],
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'المجالات التي يقدم فيها دورات وخدمات: ',
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
                return getBlackEmptyChip(text: instituteDetailsEntity.categories[index].nameAr+' | '+instituteDetailsEntity.categories[index].nameEn);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: instituteDetailsEntity.categories.length),
        ),
      ],
    );
  }
}
