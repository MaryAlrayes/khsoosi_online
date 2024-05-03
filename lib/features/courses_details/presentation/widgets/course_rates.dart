import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';

class CourseRates extends StatelessWidget {
  const CourseRates({super.key});

   final List<Map<String, int>> ratesDetails = const [
    {'rate': 0, 'value': 12},
    {'rate': 1, 'value': 20},
    {'rate': 2, 'value': 25},
    {'rate': 3, 'value': 3},
    {'rate': 4, 'value': 45},
    {'rate': 5, 'value': 30},
  ];
  final int numberOfRates = 135;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildTeacherRate(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildRatesDetails(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                  separatorBuilder: (context, index) {
                    return _buildComment(context);
                  },
                  itemCount: 10),
            )
          ],
        ),
      ),
    );
  }

  Container _buildComment(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8).copyWith(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorManager.gray2.withOpacity(.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 48,
              alignment: Alignment.topRight,
              child: CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: NetworkImage(
                      'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'))),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // height: 48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                ' Zoghby',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            CustomRating(
                              initRating: 4,
                              update: false,
                              showRateText: false,
                            ),
                          ],
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy ').format(DateTime.now()).toString(),
                          style: TextStyle(fontSize: 12,color: Color(0xff74758F)),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width:
                          (MediaQuery.of(context).size.width - 48 - 48) / 1.2,
                      child: CustomReadText(
                        text:
                            'مدرس متميز وعن معرفة  معرفة معرفة معرفةمعرفةمعرفةمعرفة معرفة معرفةمعرفةمعرفةشخصية',
                        trimLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LayoutBuilder _buildRatesDetails() {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...ratesDetails
              .map((e) => _buildStatRow(constraints, e))
              .toList()
              .reversed,
        ],
      );
    });
  }

  Row _buildStatRow(BoxConstraints constraints, Map<String, int> e) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            height: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorManager.gray2,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (e['value']! / numberOfRates),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.starColorRate,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          child: Text(
            e['rate'].toString(),
            style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),
          ),
        ),
      ],
    );
  }

  Widget _buildTeacherRate() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '4.0',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CustomRating(initRating: 4, update: false, showRateText: false),
          SizedBox(
            height: 8,
          ),
          Text(
            'متوسط التقييمات',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
