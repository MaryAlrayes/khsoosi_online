// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/shared_features/domain/entities/country_entity.dart';

class InstituteInfo extends StatelessWidget {
  final List<CountryEntity> countries;
  const InstituteInfo({
    Key? key,
    required this.countries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
