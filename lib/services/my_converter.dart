import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyConverter {

  // DateTime to String

  static String dateTimeToString(DateTime? dateTime) {
    return DateFormat.yMd().format(dateTime!);
  }

  // String to Timestamp

  static Timestamp dateTimeToTimestamp(DateTime dateTime) {

    return Timestamp.fromDate(dateTime);

  }

  static DateTime timestampToDateTime(Timestamp timestamp) {

    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);

  }










}