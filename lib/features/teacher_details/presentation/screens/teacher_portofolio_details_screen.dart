// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/portofolio_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_portofolio_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/portofolio/widgets/like_dislike_buttons.dart';

import '../../../courses_services_portofolio_details/presentation/portofolio/screens/portofolio_details_screen.dart';
import '../widgets/youtube_section.dart';

class TeacherPortofolioDetailsScreen extends StatelessWidget {
  static const routeName = 'explanation_screen';
  final TeacherPortofolioEntity portofolioEntity;
  final TeacherDetailsEntity teacherDetailsEntity;
  const TeacherPortofolioDetailsScreen({
    Key? key,
    required this.portofolioEntity,
    required this.teacherDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PortofolioDetailsScreen(
      id: portofolioEntity.id,
    );
  }
}
