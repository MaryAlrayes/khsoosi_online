// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

class RatesStat extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  const RatesStat({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildTeacherRate(),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 3,
          child: _buildRatesDetails(),
        )
      ],
    );
  }

  Widget _buildRatesDetails() {
    Map<int, int> ratesDetails = {
      5: 0,
      4: 0,
      3: 0,
      2: 0,
      1: 0,
      0: 0,
    };
    teacherDetailsEntity.reviewEntity.map((e) {
      if (ratesDetails.containsKey(ratesDetails[e.rate!.round()])) {
        return ratesDetails[e.rate!.round()] =
            ratesDetails[e.rate!.round()]! + 1;
      } else {
        return ratesDetails[e.rate!.round()] = 0;
      }
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ratesDetails.keys
              .map((e) => _buildStatRow(constraints, e, ratesDetails[e]!))
              .toList(),
        );
      },
    );
  }

  Row _buildStatRow(BoxConstraints constraints, int rate, int counter) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            height: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorManager.gray2,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor:
                      (counter / teacherDetailsEntity.reviewEntity.length),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.starColorRate,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          child: Text(
            rate.toString(),
            style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherRate() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            teacherDetailsEntity.averageRate!.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CustomRating(
              initRating: teacherDetailsEntity.averageRate!,
              update: false,
              showRateText: false),
          SizedBox(
            height: 8,
          ),
          Text(
            'متوسط التقييمات',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
