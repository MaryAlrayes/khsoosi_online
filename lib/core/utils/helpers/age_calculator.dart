class AgeCalculator {
  static int getAg(DateTime date) {
    DateTime today = DateTime.now();
    var year = today.year - date.year;
    var mth = today.month - date.month;
    var days = today.day - date.day;
    if (days < 30) mth--;
    if (mth < 12) year--;
    return year;
  }
}
