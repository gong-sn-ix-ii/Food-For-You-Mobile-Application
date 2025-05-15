// ignore_for_file: unnecessary_import, implementation_imports, camel_case_types, unused_local_variable, file_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors, sort_child_properties_last, prefer_final_fields, override_on_non_overriding_member, annotate_overrides, unnecessary_brace_in_string_interps, avoid_print, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/services/service.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Generate_QRCODE extends StatefulWidget {
  const Generate_QRCODE({super.key});

  @override
  State<Generate_QRCODE> createState() => _Generate_QRCODEState();
}

class _Generate_QRCODEState extends State<Generate_QRCODE> {
  @override
  TextEditingController _link_ = TextEditingController();
  String url_QRcode = "";
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    Future.delayed(Duration.zero, () async {
      url_QRcode = await "/user/" + await db.my_uid();
      setState(() {});
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Generate QR Code\t\t\t\t\t\t\t\t\t   ")],
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        width: MediaQuery.of(context).size.width / 50)),
                onPressed: null,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 2000,
                      MediaQuery.of(context).size.width / 35,
                      MediaQuery.of(context).size.width / 2000,
                      MediaQuery.of(context).size.width / 35),
                  child: QrImage(
                    data: url_QRcode,
                    size: MediaQuery.of(context).size.width / 1.6,
                  ),
                ),
              ),
              Divider(
                height: MediaQuery.of(context).size.width / 10,
                thickness: MediaQuery.of(context).size.width / 100,
                endIndent: MediaQuery.of(context).size.width / 8,
                indent: MediaQuery.of(context).size.width / 8,
                color: Colors.black,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 8,
                      0,
                      MediaQuery.of(context).size.width / 8,
                      0),
                  child: TextFormField(
                    controller: _link_,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width / 20),
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 10,
                            )),
                        prefixIcon: Icon(
                          Icons.link_rounded,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 10,
                        ),
                        hintText: "Enter The https://Link/URL",
                        hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 20)),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_link_.text == "") {
                      _link_.text = "ทีหลังใส่ค่ามาด้วยเข้าใจไหม!";
                      print("######### URL = ${url_QRcode}");
                      _link_.clear();
                      Fluttertoast.showToast(
                        msg: "อย่ามาทำเนียน : กลับไปใส่ URL ก่อน เข้าใจไหม!!",
                        gravity: ToastGravity.CENTER,
                      );
                    } else {
                      url_QRcode = _link_.text;
                      print("######### URL = ${url_QRcode}");
                      _link_.clear();
                      Fluttertoast.showToast(
                        msg: "Generate URL : ${url_QRcode}",
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 40),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.create,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        Text(
                          "GENERATE QR CODE",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 18,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.black, width: 2))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
