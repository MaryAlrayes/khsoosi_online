import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/statistics/data/models/requests_series_data_model.dart';

import '../../domain/entities/teacher_stat_entity.dart';

class TeacherStatModel extends TeacherStatEntity {
  TeacherStatModel(
      {required super.coursesCount,
      required super.servicesCount,
      required super.reviewsCount,
      required super.portofolioCount,
      required super.currentMonthRequestCount,
      required super.lastYearRequestCount,
      required super.data});

  factory TeacherStatModel.fromJson(Map<String, dynamic> map) {
    List<int> values = (map['requests_array'] as List<dynamic>)
        .map(
          (e) => e as int,
        )
        .toList();
    List<String> months = (map['date_array'] as List<dynamic>)
        .map(
          (e) => e as String,
        )
        .toList();
    return TeacherStatModel(
      coursesCount: map['courses_count'] ?? 0,
      servicesCount: map['services_count'] ?? 0,
      reviewsCount: map['reviews_count'] ?? 0,
      portofolioCount: map['portfolio_count'] ?? 0,
      currentMonthRequestCount: map['current_month_contact_request_count'] ?? 0,
      lastYearRequestCount: map['last_12month_contact_request_count'] ?? 0,
      data: List.generate(
        values.length,
        (index) => RequestsSeriesDataModel.fromJson(
          month: months[index],
          value: values[index],
        ),
      ).toList(),
    );
  }
}
