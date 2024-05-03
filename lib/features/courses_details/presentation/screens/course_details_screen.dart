import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/sliver_tabbar.dart';
import 'package:khosousi_online/features/courses_details/presentation/widgets/about_course.dart';
import 'package:khosousi_online/features/courses_details/presentation/widgets/about_instructor.dart';
import 'package:khosousi_online/features/courses_details/presentation/widgets/course_details.dart';
import 'package:khosousi_online/features/courses_details/presentation/widgets/course_rates.dart';

class CourseDetailsScreen extends StatefulWidget {
  static const routeName = 'course_details_screen';
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> with TickerProviderStateMixin {
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
      appBar: _buildappbar(),
    body:  NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: CourseDetails()
            ),
            SliverTabbar(
              tabController: _tabController,
              tabs: ['عن الدورة','عن المدرب','التقييمات']
                  ,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [AboutCourse(),AboutInstructor(),CourseRates()]
              .map(
                (e) => Container(
                  color: ColorManager.scaffoldBackground,
                  child: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  AppBar _buildappbar() {
    return AppBar(
      title: Text('مهارات الحاسب الالي'),
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
