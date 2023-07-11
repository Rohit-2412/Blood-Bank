import 'dart:math';

import 'package:intl/intl.dart';

class HelperFunctions {
  // return data in format of dd/mm/yy
  static String formatDate(String timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return DateFormat('dd/MM/yy').format(date);
  }

  // return time in format hh:mm if date is same otherwise return date in format dd/mm hh:mm
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

  // create a random 20 digit alphanumeric string
  static String generateUniqueId() {
    String randomString = "";

    const String characters =
        "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for (int i = 1; i <= 20; i++) {
      int index = Random().nextInt(characters.length);
      randomString += characters[index];

      // add a hyphen after 4 characters
      if (i % 4 == 0 && i != 0) {
        randomString += "-";
      }
    }
    return randomString;
  }
}
