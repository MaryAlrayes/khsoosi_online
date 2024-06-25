// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/ui/widgets/sliver_tabbar.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/domain/entities/course_service_details_entity.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/widgets/details_section.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/widgets/tab_about.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/widgets/tab_instructor.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/widgets/tab_rates.dart';
enum DetailsType{
  course,
  service
}
class MainDetailsContent extends StatefulWidget {
  final CourseServiceDetailsEntity courseDetailsEntity;
  final DetailsType detailsType;
  const MainDetailsContent({
    Key? key,
    required this.courseDetailsEntity,
    required this.detailsType,
  }) : super(key: key);

  @override
  State<MainDetailsContent> createState() => _MainDetailsContentState();
}

class _MainDetailsContentState extends State<MainDetailsContent>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappbar(widget.courseDetailsEntity.title),
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: DetailsSection(
                detailsEntity: widget.courseDetailsEntity,
              ),
            ),
            SliverTabbar(
              tabController: _tabController,
              tabs:widget.detailsType == DetailsType.course? ['عن الدورة', 'عن المدرب', 'التقييمات']:['التفاصيل', 'عن المدرب', 'التقييمات'],
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TabAbout(
              courseDetailsEntity: widget.courseDetailsEntity,
            ),
            TabInstructor(
              teacher: widget.courseDetailsEntity.teacher,
              detailsType:widget.detailsType ,
            ),
            TabRates(
              courseDetailsEntity: widget.courseDetailsEntity,
            ),
          ]
              .map(
                (e) => e,
              )
              .toList(),
        ),
      ),
    );
  }

  AppBar _buildappbar(String title) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
        ),
        PopupMenuButton<int>(
          onSelected: (item) {},
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 1,
              child: Text('تبليغ عن المحتوى'),
              onTap: () async {},
            ),
          ],
        ),
      ],
    );
  }
}
