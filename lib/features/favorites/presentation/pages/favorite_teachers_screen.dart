import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:khosousi_online/features/favorites/presentation/widgets/favorite_teacher_item.dart';

class FavoriteTeacherScreen extends StatelessWidget {
  const FavoriteTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              child: _buildTeachersGrid( context),
            )
          ],
        ),
      ),
    );

  }

  Widget _buildTeachersGrid( BuildContext context) {
    return MasonryGridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return FavoriteTeacherItem(

        );
      },
    );
  }




}
