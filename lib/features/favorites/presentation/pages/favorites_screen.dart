import 'package:flutter/material.dart';
import '../../../../core/managers/color_manager.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = 'favorites_scree';
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: ColorManager.gray3,
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.black,
              indicatorColor: ColorManager.black,
              labelColor: Colors.white,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: ColorManager.black,
                borderRadius: BorderRadius.circular(
                  0,
                ),
              ),
              labelStyle: TextStyle(fontSize: 14),
              tabs: <Widget>[
                Tab(
                  text: "الدورات",
                ),
                Tab(
                  text: "الخدمات",
                ),
                Tab(
                  text: "المدرسون",
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: <Widget>[Container(), Container(), Container()],
            ),
          ),
        ],
      ),
    );
  }
}
