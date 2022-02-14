import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
final DateFormat timeFormat = DateFormat.Hms();

String formatDateTime(DateTime dateTime) {
  return '${dateFormat.format(dateTime)} ${timeFormat.format(dateTime)}';
}

int daysAgo(DateTime dateTime) {
  return DateTime.now().difference(dateTime).inDays;
}

class DateTimeTools {
  static final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
  static final DateFormat timeFormat = DateFormat.Hms();

  static String formatDateTime(DateTime dateTime) {
    return '${dateFormat.format(dateTime)} ${timeFormat.format(dateTime)}';
  }

  static int daysAgo(DateTime dateTime) {
    return DateTime.now().difference(dateTime).inDays;
  }
}
