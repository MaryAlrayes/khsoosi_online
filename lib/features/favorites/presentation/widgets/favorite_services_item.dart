import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

class FavoriteServicesItem extends StatelessWidget {
  const FavoriteServicesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // pushScreen(context: context, screen: ServiceDetailsScreen(id: serviceEntity.id));
      },
      child: Card(
        elevation: 1,
        shadowColor: Colors.black12,
        child: Container(
          height: 160,
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildName(),
                          SizedBox(
                            width: 4,
                          ),
                          _buildFav()
                        ],
                      ),
                      
                      _buildLocation(),
                      SizedBox(
                        height: 4,
                      ),
                      _buildServiceProvider(),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 30,
                        child: _buildCategories(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildServiceProvider() {
    return Row(
      children: [
        Icon(
          Icons.person,
          size: 16,
          color: ColorManager.green1,
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            'مقدم الدورة',
            style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Row _buildLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
          color: ColorManager.orange1,
        ),
        SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            'السعودية' + ' /' + 'الرياض',
            style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Container _buildCategories() {
    return Container(
        height: 30,
        alignment: Alignment.center,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return getGrayChip(text: 'رياضيات' + ' | ' + 'Math');
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: 10,
        ));
  }

  Widget _buildFav() {
    return IconButton(
      padding: EdgeInsets.all(0),

        onPressed: () {},
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ));
  }

  Flexible _buildName() {
    return Flexible(
      child: Text(
        'اسم الخدمة',
        maxLines: 2,
        style: kBlackBoldTextStyle,
      ),
    );
  }

  ClipRRect _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
      child: CustomImage(image: EndPointsManager.servicesDefaultImageBaseUrl),
    );
  }
}
