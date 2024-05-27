// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khosousi_online/features/rates/domain/entities/rate_entity.dart';
import 'package:khosousi_online/features/rates/presentation/widgets/comments_section.dart';
import 'package:khosousi_online/features/rates/presentation/widgets/rates_statistics.dart';

class RatesSection extends StatelessWidget {
  final List<RateEntity> rates;
  final double? mainRate;

  const RatesSection({
    Key? key,
    required this.rates,
  required  this.mainRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: rates.isEmpty ? Text('لا يوجد تقييمات') : _buildRates(context),
    );
  }

  Widget _buildRates(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            child: RatesStatistics(
              rates: rates,
              mainRate: mainRate,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.9,
            child: CommentsSection(
              rates: rates,
            ),
          ),
        ],
      ),
    );
  }
}
