import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/features/teacher_rates/presentation/widgets/teacher_reply.dart';
import 'package:khosousi_online/features/teacher_rates/presentation/widgets/user_rate_item.dart';

import '../../../../core/utils/helpers/date_formatter.dart';

class TeacherRatesScreen extends StatelessWidget {
  const TeacherRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقييماتي'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => SizedBox(
          height: 16,
        ),
        separatorBuilder: (context, index) {
          return _buildComment(
            context,
          );
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildComment(
    BuildContext context,
  ) {
    return Column(
      children: [
        _buildUserComment(context),
        SizedBox(
          height: 8,
        ),
        _buildTeacherReply(
          context,
        ),
      ],
    );
  }

  Widget _buildUserComment(BuildContext context) {
    return UserRateItem();
  }

  Widget _buildTeacherReply(
    BuildContext context,
  ) {
    return TeacherReply();
  }
}
