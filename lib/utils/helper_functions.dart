import 'package:intl/intl.dart';

// return time in format hh:mm if date is same otherwise return date in format dd/mm hh:mm
class HelperFunctions {
  static String formatTime(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) {
      return DateFormat('hh:mm a').format(date);
    } else {
      return DateFormat('dd/MM HH:mm').format(date);
    }
  }
}
