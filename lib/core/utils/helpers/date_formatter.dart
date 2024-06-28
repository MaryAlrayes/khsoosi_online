import 'package:intl/intl.dart';

class DateFormatter {
  static String getFormatedDate(String date,[bool withTime=false]) {
    DateTime dateTime = DateTime.parse(date);
    if(withTime){
      return    DateFormat('dd-MM-yyyy (hh:mm a)').format(dateTime);
    }
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
