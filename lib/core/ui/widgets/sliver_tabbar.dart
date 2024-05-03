// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';

class SliverTabbar extends StatelessWidget {
  final List<String> tabs;
  final TabController tabController;
  const SliverTabbar({
    Key? key,
    required this.tabs,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leadingWidth: 0,
      titleSpacing: 0,
      toolbarHeight: 40,
      title: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorManager.gray3,
            borderRadius: BorderRadius.circular(
              0,
            )),
        child: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          indicatorColor: ColorManager.black,
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: ColorManager.black,
            borderRadius: BorderRadius.circular(
              0,
            ),
          ),
          tabs: tabs
              .map((e) => Tab(
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
