// ignore_for_file: unnecessary_import, unused_import, implementation_imports, camel_case_types, sort_child_properties_last, prefer_const_constructors, duplicate_ignore, file_names, unused_local_variable, avoid_print, unused_element, dead_code, no_leading_underscores_for_local_identifiers, override_on_non_overriding_member, annotate_overrides, must_call_super, unnecessary_brace_in_string_interps, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';

class Messaging_BTN extends StatefulWidget {
  const Messaging_BTN({super.key});

  @override
  State<Messaging_BTN> createState() => _Messaging_BTNState();
}

class _Messaging_BTNState extends State<Messaging_BTN> {
  String master_id = "";
  Service sv = Service.instance;
  @override

  @override
  final auth = FirebaseAuth.instance;
  String resultText = 'ว่างเปล่า';

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("${auth.currentUser?.email}")),
          backgroundColor: Colors.black,
        ),
        body: Center(
          // ignore: missing_required_param
          child: Text(
            // ignore: missing_required_param
            "${sv.Generate_DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year, del_value: -1)}",
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
