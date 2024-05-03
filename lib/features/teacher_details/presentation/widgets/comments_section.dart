// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_review_entity.dart';

import '../../../../core/managers/color_manager.dart';

import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';

class CommentsSection extends StatelessWidget {
  final TeacherDetailsEntity teacherDetailsEntity;

  const CommentsSection({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => SizedBox(
        height: 12,
      ),
      separatorBuilder: (context, index) {
        return _buildComment(
          context,
          teacherDetailsEntity.reviewEntity[index],
        );
      },
      itemCount: teacherDetailsEntity.reviewEntity.length + 1,
    );
  }

  Widget _buildComment(
      BuildContext context, TeacherDetailsReviewEntity review) {
    return Column(
      children: [
        _buildUserComment(review, context),
        if (review.reply.isNotEmpty) ...[
          SizedBox(
            height: 8,
          ),
          _buildTeacherReply(context, review),
        ]
      ],
    );
  }

  Row _buildUserComment(
      TeacherDetailsReviewEntity review, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            alignment: Alignment.topRight,
            child: CustomImage(
              image: review.image,
              isCircle: true,
              radius: 20,
            ),
          ),
        ),
        Expanded(
          child: Container(
            key: UniqueKey(),
            width: double.infinity,
            padding: const EdgeInsets.all(12).copyWith(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorManager.gray2.withOpacity(.3),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              // height: 48,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          review.userName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      if (review.rate != null)
                                        CustomRating(
                                          initRating: review.rate!,
                                          update: false,
                                          showRateText: false,
                                        ),
                                    ],
                                  ),
                                  Text(
                                    DateFormatter.getFormatedDate(review.date),
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff74758F)),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                width: (MediaQuery.of(context).size.width -
                                        48 -
                                        48) /
                                    1.2,
                                child: CustomReadText(
                                  text: review.comment,
                                  trimLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container _buildTeacherReply(
      BuildContext context, TeacherDetailsReviewEntity review) {
    return Container(
      margin: const EdgeInsets.only(right: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              alignment: Alignment.topRight,
              child: CustomImage(
                image: teacherDetailsEntity.imagePath,
                isCircle: true,
                radius: 10,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8).copyWith(top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.gray2.withOpacity(.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    teacherDetailsEntity.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width:
                          (MediaQuery.of(context).size.width - 48 - 48) / 1.2,
                      child: CustomReadText(
                        text: review.reply,
                        trimLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
