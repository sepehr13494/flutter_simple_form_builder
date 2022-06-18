import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DateManager{
  static String getLocalDateFromDate(DateTime dateTime,BuildContext context){
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String getLocalDateFromDateWithTime(DateTime dateTime,BuildContext context){
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }
}