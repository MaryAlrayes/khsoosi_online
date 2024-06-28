// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';

import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/utils/enums/enums.dart';

import '../../../../../../core/ui/widgets/custom_image.dart';
import '../../../../../location/domain/entities/country_entity.dart';

class CountriesCodesPicker extends StatelessWidget {
  final List<CountryEntity> countries;
  final CountryEntity? initalValue;
  final Function onChanged;
  const CountriesCodesPicker({
    Key? key,
    required this.countries,
    required this.initalValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDropDown<CountryEntity>(
        hintText: 'رمز الدولة',
        selectedItemBuilder:(context){
          return countries.map((e) =>
           SizedBox(
             child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      FittedBox(child:  Text(
                          e.callingCode + '+',
                          style: TextStyle(fontSize: 14),
                        ),),
                        SizedBox(
                          width: 8,
                        ),
                        CustomImage(
                          image: EndPointsManager.countryImageBaseUrl +
                              e.countryCode +
                              EndPointsManager.countryImageExtension,
                          width: 16,
                          height: 16,
                          isCircle: false,
                        ),
                      ],
                    ),
           ),).toList();

        },
        items: countries
            .map((e) => DropdownMenuItem(
                  child: Container(  width:150,
                  padding:EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                      Expanded(child:  Text(
                          e.countryNameAr.isEmpty? e.countryNameEn:'' ,
                          style: TextStyle(fontSize: 14),
                        ),),
                        SizedBox(
                          width: 8,
                        ),
                        CustomImage(
                          image: EndPointsManager.countryImageBaseUrl +
                              e.countryCode +
                              EndPointsManager.countryImageExtension,
                          width: 16,
                          height: 16,
                          isCircle: false,
                        ),
                      ],
                    ),
                  ),
                  value: e,
                ))
            .toList(),
        initSelectedValue:
            initalValue == CountryEntity.empty() ? null : initalValue,
        onChanged: (value) {
          onChanged(value);
        });
  }
}
