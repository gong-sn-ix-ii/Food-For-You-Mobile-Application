// ignore_for_file: unused_import, non_constant_identifier_names, empty_constructor_bodies, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';

class InformationModel {
  String? res_name;
  String? res_streetAdress;
  String? res_phoneNumber;
  String? res_code;
  String? res_comment;
  InformationModel({
    required this.res_name,
    required this.res_streetAdress,
    required this.res_phoneNumber,
    required this.res_code,
    required this.res_comment,
  });
  factory InformationModel.fromMap(Map<String, dynamic> information) {
    String? res_name = information["name"];
    String? res_streetAdress = information["street"];
    String? res_phoneNumber = information["phoneNumber"];
    String? res_code = information["code"];
    String? res_comment = information["comment"];
    if (information == null) {
      return InformationModel(
          res_name: null,
          res_streetAdress: null,
          res_phoneNumber: null,
          res_code: null,
          res_comment: null);
    } else {
      return InformationModel(
          res_name: res_name,
          res_streetAdress: res_streetAdress,
          res_phoneNumber: res_phoneNumber,
          res_code: res_code,
          res_comment: res_comment);
    }
  }
  Map<String, dynamic> Information_ToMap() {
    return {
      "name": res_name,
      "street": res_streetAdress,
      "phoneNumber": res_phoneNumber,
      "code": res_code,
      "comment": res_comment
    };
  }
}
