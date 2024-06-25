// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/sliver_tabbar.dart';
import 'package:khosousi_online/features/accounts/presentation/profile_info/common/screens/institute_info.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_entity.dart';
import 'package:khosousi_online/features/institute_details/presentation/widgets/indtitute_info_content.dart';
import 'package:khosousi_online/features/institute_details/presentation/widgets/institute_certificates.dart';
import 'package:khosousi_online/features/institute_details/presentation/widgets/institute_courses.dart';

class InstituteDetails extends StatefulWidget {
  final InstituteDetailsEntity instituteDetailsEntity;
  const InstituteDetails({
    Key? key,
    required this.instituteDetailsEntity,
  }) : super(key: key);

  @override
  State<InstituteDetails> createState() => _InstituteDetailsState();
}

class _InstituteDetailsState extends State<InstituteDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = [];
  List<Widget> _content = [];
  @override
  void initState() {
    tabs.add('الدورات (${widget.instituteDetailsEntity.courses.length})');
    _content.add(InstituteCourses(courses: widget.instituteDetailsEntity.courses,));

    //Todo:fill number of certificates
    tabs.add('الشهادات (${10})');
    _content.add(InstituteCertificates());

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
    return Scaffold(
        appBar: _buildAppBar(),
        floatingActionButton: _buildContactUs(),
        body: NestedScrollView(
            scrollDirection: Axis.vertical,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: InstituteInfoContent(
                    instituteDetailsEntity: widget.instituteDetailsEntity,
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
            )));
  }

  Widget _buildContactUs() {
    return Theme(
      data: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      child: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            Container(
              child: FloatingActionButton(
                onPressed: () {},
                heroTag: "phone btn",
                tooltip: 'Phone button',
                child: Icon(Icons.phone_enabled_sharp, color: Colors.white),
                backgroundColor: ColorManager.blue1,
              ),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {},
                heroTag: "whatsapp btn",
                tooltip: 'Whatsapp button',
                child: Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
                backgroundColor: Colors.green,
              ),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: () {},
                heroTag: "message btn",
                tooltip: 'message button',
                child: Icon(FontAwesomeIcons.solidMessage, color: Colors.white),
                backgroundColor: ColorManager.black,
              ),
            ),
          ],
          colorStartAnimation: ColorManager.blue2,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('${widget.instituteDetailsEntity.name}'),
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
