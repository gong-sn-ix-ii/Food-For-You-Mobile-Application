// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names, must_be_immutable, file_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'AccountUser.dart';

class boxInput extends StatefulWidget {
  String texts = '';
  List<String> status = [
    'Email',
    'Password',
    'ConfirmPassword',
    'Date',
    'PhonNumber'
  ];

  IconData icons = Icons.close;
  double sizeRadius = 30;
  Color colorText = Colors.white, colorHint = Colors.white24;
  bool onModePassword = false;
  TextInputType formatInputType = TextInputType.text;

  boxInput(
      this.texts, this.icons, this.sizeRadius, this.colorText, this.colorHint,
      {required this.status,
      this.onModePassword = false,
      this.formatInputType = TextInputType.text});

  @override
  State<boxInput> createState() => _boxInputState();
}

class _boxInputState extends State<boxInput> {
  Function? eiei;
  final fromKey = GlobalKey();
  AccountUser profile = AccountUser();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 15, 20, 0),
            child: Text(''),
          ),
        ],
      ),
    );
  }
}
