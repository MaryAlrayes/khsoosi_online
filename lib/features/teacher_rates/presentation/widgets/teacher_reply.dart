// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';

import '../../domain/entities/teacher_review_entity.dart';

class TeacherReply extends StatefulWidget {
 final TeacherReviewEntity review;
  const TeacherReply({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  State<TeacherReply> createState() => _TeacherReplyState();
}

class _TeacherReplyState extends State<TeacherReply> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8).copyWith(top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.gray3.withOpacity(.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildName(context),
                  SizedBox(height: 8),
                  _buildComment(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible _buildComment(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        width: (MediaQuery.of(context).size.width - 48 - 48) / 1.2,
        child: CustomReadMoreText(
          text: widget.review.teacherReply,
          trimLines: 2,
        ),
      ),
    );
  }

  Text _buildName(BuildContext context) {
    return Text(
      context.read<AuthRepo>().getUserInfo()!.name ,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: Alignment.topRight,
        child: CustomImage(
          image: context.read<AuthRepo>().getUserInfo()!.image,
          isCircle: true,
          radius: 10,
        ),
      ),
    );
  }
}
