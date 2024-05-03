// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';

import 'package:khosousi_online/features/search/domain/entities/search_filter_entity.dart';

class SearchInstitutesFilterSection extends StatelessWidget {
  final SearchFilterEntity searchFilterEntity;
  const SearchInstitutesFilterSection({
    Key? key,
    required this.searchFilterEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.h,
      spacing: 8.w,
      children: [
        _buildRow(
          'الدولة:',
          searchFilterEntity.country == null
              ? 'غير محدد'
              : searchFilterEntity.country!.countryNameAr.isNotEmpty
                  ? searchFilterEntity.country!.countryNameAr
                  : searchFilterEntity.country!.countryNameEn,
          searchFilterEntity.country != null,
          searchFilterEntity.country != null
              ? ColorManager.green1
              : ColorManager.gray1,
        ),
        _buildRow(
          'المدينة:',
          searchFilterEntity.city == null
              ? 'غير محدد'
              : searchFilterEntity.city!.nameAr.isNotEmpty
                  ? searchFilterEntity.city!.nameAr
                  : searchFilterEntity.city!.nameEn,
          searchFilterEntity.city != null,
          searchFilterEntity.city != null
              ? ColorManager.green1
              : ColorManager.gray1,
        ),
        _buildRow(
          'التخصص:',
          searchFilterEntity.speciality == null
              ? 'غير محدد'
              : searchFilterEntity.speciality!.name_ar.isNotEmpty
                  ? searchFilterEntity.speciality!.name_ar
                  : searchFilterEntity.speciality!.name_en,
          searchFilterEntity.speciality != null,
          searchFilterEntity.speciality != null
              ? ColorManager.green1
              : ColorManager.gray1,
        ),
      ],
    );
  }

  Row _buildRow(
    String label,
    String text,
    bool withIcon,
    Color backgroundColor,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        SizedBox(
          width: 4.w,
        ),
        CustomChipItem(
          label: text,
          iconData: withIcon ? Icons.check : null,
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
        )
      ],
    );
  }
}
