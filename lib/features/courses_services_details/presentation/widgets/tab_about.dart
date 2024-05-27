// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/courses_services_details/domain/entities/course_service_details_entity.dart';

class TabAbout extends StatelessWidget {
  final CourseServiceDetailsEntity courseDetailsEntity;
  const TabAbout({
    Key? key,
    required this.courseDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            if (courseDetailsEntity.summary.isNotEmpty) ...[
              Text(
                CustomHtmlParser.parseHtml(courseDetailsEntity.summary),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
              Divider(),
            ],
            if (courseDetailsEntity.description.isNotEmpty)
              CustomReadText(
                text:
                    CustomHtmlParser.parseHtml(courseDetailsEntity.description),
                trimLines: 5,
              ),
          ],
        ),
      ),
    );
  }
}
