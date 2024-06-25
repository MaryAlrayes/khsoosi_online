// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/services/screens/service_details_screen.dart';
import 'package:khosousi_online/features/search/domain/entities/service_entity.dart';

import '../../../../../core/ui/widgets/custom_image.dart';

class ServiceItem extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const ServiceItem({
    Key? key,
    required this.serviceEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        barPushScreen(context: context, screen: ServiceDetailsScreen(id: serviceEntity.id));
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildName(),SizedBox(width: 4,), _buildFav()],
                      ),
                      SizedBox(
                        height: 4,
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
            serviceEntity.publisherName,
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
           serviceEntity.countryAr+' /'+serviceEntity.cityAr,
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
            return getGrayChip(text: serviceEntity.categories[index].nameAr+' | '+ serviceEntity.categories[index].nameEng);
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 8,
          ),
          itemCount: serviceEntity.categories.length,
        ));
  }

  Icon _buildFav() => Icon(Icons.favorite_border);

  Flexible _buildName() {
    return Flexible(
      child: Text(
       serviceEntity.title,
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
          serviceEntity.imagePath,
      ),
    );
  }
}
