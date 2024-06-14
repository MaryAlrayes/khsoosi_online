import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:khosousi_online/features/favorites/presentation/widgets/favorite_courses_item.dart';

class FavoriteCoursesScreen extends StatelessWidget {
  const FavoriteCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return FavoriteCoursesItem();
        },
      ),
    );
  }
}
