// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_services_entity.dart';

class EducationalServices extends StatelessWidget {
  final List<TeacherServicesEntity> services;
  const EducationalServices({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: services.isEmpty
          ? Text('لا يوجد خدمات يقدمها المدرس')
          : ListView.separated(
              itemBuilder: (context, index) {
                return _buildCard(index);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                );
              },
              itemCount: services.length),
    );
  }

  Card _buildCard(int index) {
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
            Expanded(flex: 1, child: CustomImage(image: services[index].image)),
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
                    _buildTitle(index),
                    SizedBox(
                      height: 4,
                    ),
                    _buildAddress(index),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 40,
                      child: _buildCategories(index),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView _buildCategories(int index) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => getGrayChip(
          text: services[index].categories[i].nameAr +
              ' | ' +
              services[index].categories[i].nameEn),
      separatorBuilder: (context, index) => SizedBox(
        width: 8,
      ),
      itemCount: services[index].categories.length,
    );
  }

  Widget _buildAddress(int index) {
    String location = '';
    if (services[index].countryAr.isNotEmpty) {
      location += services[index].countryAr;
    }
    if (services[index].cityAr.isNotEmpty) {
      location.isNotEmpty ? location += ' /' : '';
      location += services[index].cityAr;
    }
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          location,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'Roboto', fontSize: 14),
        ),
      ],
    );
  }

  Text _buildTitle(int index) {
    return Text(
      services[index].title,
      maxLines: 2,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }
}
