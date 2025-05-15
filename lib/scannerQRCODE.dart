// ignore_for_file: implementation_imports, file_names, unused_local_variable, unused_import, unnecessary_import, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Generate_QRcode.dart';
import 'package:foodapp/Scan_QRcode.dart';
import 'package:foodapp/services/camera_scanQR.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRscan extends StatefulWidget {
  const QRscan({super.key});

  @override
  State<QRscan> createState() => _QRscanState();
}

class _QRscanState extends State<QRscan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("QR CODE            "),
            ],
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.qr_code_scanner_rounded,
              size: MediaQuery.of(context).size.width / 1.5,
            ),
          ),

          /*QrImage(
            data: "https://www.youtube.com/watch?v=kd1CLYLymbI&list=LL&index=1",
            size: MediaQuery.of(context).size.width / 1.5,
          ),*/
          Divider(
            height: MediaQuery.of(context).size.width / 10,
            thickness: MediaQuery.of(context).size.width / 100,
            endIndent: MediaQuery.of(context).size.width / 8,
            indent: MediaQuery.of(context).size.width / 8,
            color: Colors.black,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Generate_QRCODE()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
              child: Center(
                child: Text(
                  "GENERATE QR CODE",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 18,
                      color: Colors.black),
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
            height: MediaQuery.of(context).size.width / 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRViewExample()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 40),
              child: Center(
                child: Text(
                  "SCAN QR CODE",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 18,
                      color: Colors.black),
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black, width: 2))),
          ),
        ],
      ),
    );
  }
}
