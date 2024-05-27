import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_entity.dart';

import '../../../rates/presentation/pages/rates_section.dart';

class TabRates extends StatelessWidget {
  final CourseServiceDetailsEntity courseDetailsEntity;
  const TabRates({super.key, required this.courseDetailsEntity});

  @override
  Widget build(BuildContext context) {
    return RatesSection(
      rates: courseDetailsEntity.peopleRates,

    // Todo: this rate is missing from API
      mainRate: 0,
    );
  }
}
