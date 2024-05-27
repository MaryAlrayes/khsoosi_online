// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/search/cubit/search_cubit.dart';

class CustomCircle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final SearchType searchType;
  const CustomCircle({
    Key? key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.searchType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          shape: CircleBorder(),
          onPressed: () {
            BlocProvider.of<SearchCubit>(context).setType(searchType);
            BlocProvider.of<FilterSearchCubit>(context).resetFilter();
          },
          child: PhysicalModel(
            color: isSelected
                ? ColorManager.lightOrange
                : ColorManager.gray2.withOpacity(0.3),
            elevation: isSelected ? 1 : 0,
            shadowColor: isSelected
                ? ColorManager.lightOrange
                : ColorManager.gray2.withOpacity(0.3),
            borderRadius: BorderRadius.circular(26.r),
            shape: BoxShape.circle,
            child: CircleAvatar(
              backgroundColor:
                  isSelected ? ColorManager.lightOrange : ColorManager.gray2,
              radius:isSelected?34: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected ? ColorManager.orange : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontSize:  isSelected ?14:12,
            fontWeight: isSelected? FontWeight.bold:FontWeight.w400
          ),
        ),
      ],
    );
  }
}
