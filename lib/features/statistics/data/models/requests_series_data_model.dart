import 'package:equatable/equatable.dart';
import 'package:khosousi_online/features/statistics/domain/entities/requests_series_data_entity.dart';

class RequestsSeriesDataModel extends RequestsSeriesDataEntity {
  RequestsSeriesDataModel({
    required super.month,
    required super.value,
  });
  factory RequestsSeriesDataModel.fromJson({required String month,required int value}) {
    return RequestsSeriesDataModel(
      value: value.toDouble(),
      month: month,
    );
  }
}
