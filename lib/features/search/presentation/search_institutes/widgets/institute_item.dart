import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

class InstituteItem extends StatelessWidget {
  const InstituteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.black12,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: _buildImage(),
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [_buildName(), _buildFav()],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 30,
                      child: _buildCategories(),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    _buildLocation(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
          color: ColorManager.green1,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          'السعودية/ الرياض',
          style: TextStyle(fontSize: 14,fontFamily: 'Roboto'),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Container(
        height: 30,

        alignment: Alignment.center,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return getGrayChip(text: 'برمجة جافا');
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: 5,
        ));
  }

  Icon _buildFav() => Icon(Icons.favorite_border);

  Flexible _buildName() {
    return Flexible(
      child: Text(
        'جبريل القادري',
        maxLines: 2,
        style:kBlackBoldTextStyle,
      ),
    );
  }

  ClipRRect _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      child: CustomImage(
        image:
            'https://images.inc.com/uploaded_files/image/1920x1080/getty_933383882_2000133420009280345_410292.jpg',
      ),
    );
  }
}
