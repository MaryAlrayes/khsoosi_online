import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/features/search/presentation/filter/cubit/filter_search_cubit.dart';
import 'package:khosousi_online/features/search/presentation/filter/widgets/location_coords_dialog_content.dart';
import 'package:khosousi_online/shared_features/presentation/bloc/coords_cubit.dart';

class SelectLocationType extends StatelessWidget {
  const SelectLocationType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterSearchCubit, FilterSearchState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _buildCard(
                  icon: FontAwesomeIcons.mapLocation,
                  text: 'المدرسون الأقرب جغرافيا',
                  onPressed: () {
                    BlocProvider.of<FilterSearchCubit>(context)
                        .setLocationType(LocationType.nearestTeacher);

                    BlocProvider.of<CoordsCubit>(context).fetchLocation();

                    _showFetchCoordsDialog(context);
                  },
                  isSelected:
                      state.filter.locationType == LocationType.nearestTeacher),
            ),
            SizedBox(
              width: 8.h,
            ),
            Expanded(
              child: _buildCard(
                  icon: FontAwesomeIcons.locationDot,
                  text: 'اختيار الدولة والمدينة',
                  onPressed: () {
                    BlocProvider.of<FilterSearchCubit>(context)
                        .setLocationType(LocationType.chooseCountey);
                  },
                  isSelected:
                      state.filter.locationType == LocationType.chooseCountey),
            ),
          ],
        );
      },
    );
  }

  void _showFetchCoordsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<CoordsCubit>(),
          ),
          BlocProvider(
            create: (context) => FilterSearchCubit(),
          ),
        ],
        child: const Dialog(
          child: LocationCoordsDialogContent(),
        ),
      ),
    );
  }

  GestureDetector _buildCard(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120,
        padding: EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1,
              color: isSelected ? ColorManager.orange : ColorManager.gray4),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected ? ColorManager.orange : ColorManager.gray4),
            SizedBox(
              height: 8,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? ColorManager.orange : ColorManager.gray4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
