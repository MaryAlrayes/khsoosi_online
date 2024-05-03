// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_portofolio_entity.dart';

class RecordedExplantaion extends StatelessWidget {
  final List<TeacherPortofolioEntity> portofolio;
  const RecordedExplantaion({
    Key? key,
    required this.portofolio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:portofolio.isEmpty?Text('لا يوجد شروحات سابقة'):
       MasonryGridView.builder(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
          ),
          itemCount: portofolio.length,
          itemBuilder: (context, index) {
            return _buildCard(index);
          }),
    );
  }

  Card _buildCard(int index) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child:CustomImage(image: portofolio[index].image)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    portofolio[index].title,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) =>
                          getGrayChip(text:portofolio[index].categories[i].nameAr+' | '+portofolio[index].categories[i].nameEn),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                      ),
                      itemCount: portofolio[index].categories.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
