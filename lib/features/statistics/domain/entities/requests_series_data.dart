 final List<RequestsSeriesData> chartData = [
    RequestsSeriesData(year:  DateTime(2022, 01),value:  20),
      RequestsSeriesData(year:DateTime(2022, 02),value: 10),
      RequestsSeriesData(year:DateTime(2022, 03),value: 20),
      RequestsSeriesData(year:DateTime(2022, 04),value: 30),
      RequestsSeriesData(year:DateTime(2022, 05),value: 20),
      RequestsSeriesData(year:DateTime(2022, 06),value: 30),
      RequestsSeriesData(year:DateTime(2022, 07),value: 10),
      RequestsSeriesData(year:DateTime(2022, 08),value: 20),
      RequestsSeriesData(year:DateTime(2022, 09),value: 10),
      RequestsSeriesData(year:DateTime(2022, 10),value: 30),
      RequestsSeriesData(year:DateTime(2022, 11),value: 30),
      RequestsSeriesData(year:DateTime(2022, 12),value: 30),
  ];
class RequestsSeriesData {
   final DateTime year;
  final double value;
  RequestsSeriesData({
    required this.year,
    required this.value,
  });
}
