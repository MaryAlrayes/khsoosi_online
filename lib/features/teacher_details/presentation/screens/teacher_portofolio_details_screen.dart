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
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_portofolio_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/like_dislike_buttons.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(portofolioEntity.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (portofolioEntity.videoLink.isNotEmpty) _buildYoutube(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildTitle(),
                    SizedBox(
                      height: 8,
                    ),
                    _buildDate(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildCategories(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildDescription(),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(),
                    _buildTeacherName(),
                    Divider(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildLikesDislikes(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLikesDislikes() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('هل كان الشرح مفيد؟'),
          SizedBox(
            height: 16,
          ),
          LikeDislikeButtons(
              likes: portofolioEntity.likes,
              dislikes: portofolioEntity.dislikes)
        ],
      );

  CustomReadText _buildDescription() {
    return CustomReadText(
      text: CustomHtmlParser.parseHtml(
        portofolioEntity.description,
      ),
      trimLines: 5,
    );
  }

  Container _buildCategories() {
    return Container(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => getGrayChip(
            text: portofolioEntity.categories[i].nameAr +
                ' | ' +
                portofolioEntity.categories[i].nameEn),
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        itemCount: portofolioEntity.categories.length,
      ),
    );
  }

  Text _buildDate() =>
      Text(DateFormatter.getFormatedDate(portofolioEntity.date),
          style: TextStyle(fontSize: 12));

  Text _buildTitle() {
    return Text(
      portofolioEntity.title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Row _buildTeacherName() {
    return Row(
      children: [
        CustomImage(
          image: teacherDetailsEntity.imagePath,
          isCircle: true,
          radius: 25,
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(teacherDetailsEntity.name
              ),
              SizedBox(
                height: 4,
              ),
              _buildRate()
            ],
          ),
        )
      ],
    );
  }

  YoutubeSection _buildYoutube() {
    return YoutubeSection(
      youtube: portofolioEntity.videoLink,
    );
  }

  Widget _buildRate() {
    return teacherDetailsEntity.averageRate != null
        ? CustomRating(
            initRating: teacherDetailsEntity.averageRate!,
            update: false,
            showRateText: true,
          )
        : Text(
            'لا يوجد تقييم',
            style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
          );
  }
}
