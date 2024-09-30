import 'package:intl/intl.dart';

class DateUtility {
  static String formatDate(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dateTime) * 1000))
        .toString();
  }

  static DateTime convertToDateTime(int seconds, int nanoseconds) {
    // Define the Unix epoch start time
    final epoch = DateTime.utc(1970, 1, 1);

    // Convert seconds to milliseconds
    int milliseconds = seconds * 1000;

    // Convert nanoseconds to milliseconds
    int nanosecondsInMilliseconds = nanoseconds ~/ 1000000; // Integer division

    // Create a DateTime object from the milliseconds since the epoch
    DateTime dateTime = epoch
        .add(Duration(milliseconds: milliseconds + nanosecondsInMilliseconds));

    return dateTime;
  }

  static String formatTimestampDate(int dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dateTime))
        .toString();
  }

  static String formatTimestampDateFromEpoch(int dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(dateTime * 1000))
        .toString();
  }

  static String dateInUTC(int dateTime) {
    return "${DateTime.fromMillisecondsSinceEpoch(dateTime).toIso8601String()}Z";
  }
}
