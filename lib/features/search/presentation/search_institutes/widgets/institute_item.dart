// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/institute_details/presentation/pages/institute_details_screen.dart';

import '../../../../../core/utils/helpers/persistent_push.dart';
import '../../../domain/entities/institute_entity.dart';

class InstituteItem extends StatelessWidget {
  final InstituteEntity instituteEntity;
  const InstituteItem({
    Key? key,
    required this.instituteEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        barPushScreen(
            context: context,
            screen: InstituteDetailsScreen(id: instituteEntity.id));
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.black12,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: _buildImage(),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildName(),
                          SizedBox(
                            width: 4,
                          ),
                          _buildFav()
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 30,
                        child: _buildCategories(),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      _buildLocation(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildLocation() {
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
        Text(
          '${instituteEntity.countryAr + ' /' + instituteEntity.cityAr}',
          style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCategories() {
    List<InstituteCategoryEntity> categories = instituteEntity.categories;
    return Container(
        height: 30,
        alignment: Alignment.centerRight,
        child: categories.isEmpty
            ? Text(
                'لا يوجد اختصاصات',
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getGrayChip(
                      text: categories[index].nameAr +
                          " | " +
                          categories[index].nameEng);
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: 8,
                ),
                itemCount: categories.length,
              ));
  }

  Icon _buildFav() => Icon(Icons.favorite_border);

  Flexible _buildName() {
    return Flexible(
      child: Text(
        instituteEntity.title,
        maxLines: 2,
        style: kBlackBoldTextStyle,
      ),
    );
  }

  ClipRRect _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      child: CustomImage(
        image: instituteEntity.imagePath,
      ),
    );
  }
}
