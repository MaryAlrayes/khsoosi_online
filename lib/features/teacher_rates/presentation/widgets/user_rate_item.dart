// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';

import '../../domain/entities/teacher_review_entity.dart';

class UserRateItem extends StatefulWidget {
  final TeacherReviewEntity review;
  const UserRateItem({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  State<UserRateItem> createState() => _UserRateItemState();
}

class _UserRateItemState extends State<UserRateItem> {
  bool showTextFields = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildUserImage(widget.review, context),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                key: UniqueKey(),
                width: double.infinity,
                padding: const EdgeInsets.all(12).copyWith(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorManager.gray3.withOpacity(.5),
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
                                _buildUserInfo(widget.review),
                                SizedBox(
                                  height: 8,
                                ),
                                _buildCommentText(context, widget.review),
                                SizedBox(
                                  height: 4,
                                ),
                              if(widget.review.teacherReply.isEmpty)  _buildAddReplyBtn()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showTextFields) _buildTextField()
            ],
          ),
        ),
      ],
    );
  }

  Container _buildTextField() {
    return Container(
      // height: 50,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                validator: (value) {},
                hintText: 'اضف ردك على التقييم...',
                isObscure: false),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xffE5E5E5)),
            padding: EdgeInsets.all(4),
            alignment: Alignment.center,
            child: FittedBox(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    showTextFields = false;
                  });
                },
                icon: Icon(
                  Icons.send_rounded,
                  color: ColorManager.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildAddReplyBtn() {
    return Container(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextButton.icon(
          icon: Icon(
            !showTextFields ? Icons.reply_rounded : Icons.close,
            size: 14,
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: TextStyle(
              fontSize: 12,
            ),
          ),
          onPressed: () {
            setState(() {
              !showTextFields ? showTextFields = true : showTextFields = false;
            });
          },
          label: Text(
            !showTextFields ? 'اضف رد' : 'إغلاق',
          ),
        ),
      ),
    );
  }

  Container _buildUserInfo(TeacherReviewEntity review) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserName(review),
              SizedBox(
                width: 4,
              ),
              if (review.rate != null) _buildRating(review),
            ],
          ),
          _buildDate(review),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              if (!review.isWhatsAppActive)
                _buildWhatAppNotAuthenticated(review),
              _buildRejected(review),
            ],
          )
        ],
      ),
    );
  }

  Flexible _buildCommentText(BuildContext context, TeacherReviewEntity review) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        width: (MediaQuery.of(context).size.width - 48 - 48) / 1.2,
        child: CustomReadMoreText(
          text: review.comment,
          trimLines: 2,
        ),
      ),
    );
  }

  Container _buildRejected(TeacherReviewEntity review) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Color(0xffD6293E), borderRadius: BorderRadius.circular(2)),
      child: Text(
        'مرفوض',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Container _buildWhatAppNotAuthenticated(TeacherReviewEntity review) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Color(0xffD6293E), borderRadius: BorderRadius.circular(2)),
      child: Text(
        'الوتس اب غير موثق',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Text _buildDate(TeacherReviewEntity review) {
    return Text(
      DateFormatter.getFormatedDate(review.date),
      style: TextStyle(fontSize: 12, color: Color(0xff74758F)),
    );
  }

  Expanded _buildUserName(TeacherReviewEntity review) {
    return Expanded(
      child: Text(
        review.userName,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  CustomRating _buildRating(TeacherReviewEntity review) {
    return CustomRating(
      initRating: review.rate!,
      update: false,
      showRateText: false,
    );
  }

  Container _buildUserImage(TeacherReviewEntity review, BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: CustomImage(
        image: review.image,
        isCircle: true,
        radius: 20,
      ),
    );
  }
}
