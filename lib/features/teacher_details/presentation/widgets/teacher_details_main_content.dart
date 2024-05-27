// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/tab_about_teacher.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/tab_certificates.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/tab_courses.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/tab_services.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/tab_rates.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/tab_portofolio.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/teacher_details.dart';

import '../../../../core/ui/widgets/sliver_tabbar.dart';

class TeacherDetailsMainContent extends StatefulWidget {
  final TeacherDetailsEntity teacherDetailsEntity;
  const TeacherDetailsMainContent({
    Key? key,
    required this.teacherDetailsEntity,
  }) : super(key: key);

  @override
  State<TeacherDetailsMainContent> createState() => _TeacherDetailsMainContentState();
}

class _TeacherDetailsMainContentState extends State<TeacherDetailsMainContent>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = [];
  List<Widget> _content = [];
  @override
  void initState() {
    tabs.add('عن المدرس');
    _content.add(TabAboutTeacher(
      teacherDetailsEntity: widget.teacherDetailsEntity,
    ));

    tabs.add(
        'التقييمات (${widget.teacherDetailsEntity.reviewEntity.length} تقييم)');
    _content.add(TabRates(
      teacherDetailsEntity: widget.teacherDetailsEntity,
    ));

    tabs.add(
        'الشروحات المسجلة (${widget.teacherDetailsEntity.portofolio.length})');
    _content.add(TabPortofolio(
      portofolio: widget.teacherDetailsEntity.portofolio,
      teacherDetailsEntity: widget.teacherDetailsEntity,
    ));

    tabs.add('الدورات (${widget.teacherDetailsEntity.courses.length})');
    _content.add(TabCourses(
      courses: widget.teacherDetailsEntity.courses,
    ));

    tabs.add(
        'الخدمات التعليمية (${widget.teacherDetailsEntity.services.length})');
    _content.add(TabServices(
      services: widget.teacherDetailsEntity.services,
    ));

    tabs.add('الشهادات (${widget.teacherDetailsEntity.certificates.length})');
    _content.add(TabCertificates(
      certificates: widget.teacherDetailsEntity.certificates,
    ));

    _tabController = TabController(length: tabs.length, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainContent(widget.teacherDetailsEntity);
  }

  Scaffold _buildMainContent(TeacherDetailsEntity teacherDetailsEntity) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbar(),
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: TeacherDetails(
                teacherDetailsEntity: teacherDetailsEntity,
              ),
            ),
            SliverTabbar(tabController: _tabController, tabs: tabs),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _content
              .map(
                (e) => Container(
                  color: Colors.white,
                  child: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text('${widget.teacherDetailsEntity.name}'),
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
