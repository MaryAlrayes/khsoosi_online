
import 'package:equatable/equatable.dart';

class RequestsSeriesDataEntity extends Equatable {
   final String month;
  final double value;
  RequestsSeriesDataEntity({
    required this.month,
    required this.value,
  });

  @override

  List<Object?> get props =>[
    month,
    value
  ];
}
