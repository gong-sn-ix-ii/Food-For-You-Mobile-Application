// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_interpolation_to_compose_strings, unused_import, invalid_required_named_param, avoid_print, dead_code, division_optimization, unnecessary_brace_in_string_interps

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/services/Database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:foodapp/services/Storage.dart';

Database db = Database.instance;
Storage storages = Storage();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

String date = DateTime.now().day.toString() +
    "/" +
    DateTime.now().month.toString() +
    "/" +
    DateTime.now().year.toString();
String time = DateTime.now().hour.toString() +
    ":" +
    DateTime.now().minute.toString() +
    ":" +
    DateTime.now().second.toString();

String time_FormatDot =
    DateTime.now().hour.toString() + "." + DateTime.now().minute.toString();

String date2 = DateTime.now().day.toString() +
    "-" +
    DateTime.now().month.toString() +
    "-" +
    DateTime.now().year.toString();

class Service {
  static Service instance = Service._();
  Service._();

  String get_UID({required int index}) {
    String text =
        "AaBbCCDDEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
    String uid = "";
    for (int i = 0; i < index; i++) {
      //Round => index
      int x = Random().nextInt(text.length); //Random X
      uid += text.substring(x, x + 1);
    }
    return uid;
  }

  String Generate_DateTime(
    int date,
    int month,
    int year, {
    @required int del_value = 0,
    @required int add_value = 0,
    @required String format = "/",
  }) {
    // month 1 3 5 7 8 10 12 have 31 |month 2 4 6 9 11 have 30
    print("Del Value = $del_value | Add Value = $add_value");
    int dateX = 0, monthX = 0, month_value1 = 0, month_value2 = 0, dateY = 0;
    dateX = date - del_value;
    dateY = dateX;
    dateX = dateX + add_value;
    print(
        "Add $add_value | Delete $del_value | DateNow : [${DateTime.now().day}] - $del_value + $add_value => dateX =  $dateX");
    int score = dateX;
    print("MonthX ${monthX}");
    month = (month < 1) ? 12 : month;
    if ((date - del_value) <= 0) {
      print("Condition Success");
      if (month == 1 ||
          month == 3 ||
          month == 5 ||
          month == 7 ||
          month == 8 ||
          month == 10 ||
          month == 12) {
        date = 31;
        print("this month have 31 day ${date}");
        if (dateX < 0) {
          date = date + dateX;
        } else {
          date = date - dateX;
        }
        print("result $date");
      } else {
        date = 30;
        print("this month have 30 day $date");
        if (dateX < 0) {
          date = date + dateX;
        } else {
          date = date - dateX;
        }
        print("result $date");
      }
    } else {
      date = date - del_value;
    }
    String dateTime = "$date$format$month$format$year";
    return dateTime;
  }
}
