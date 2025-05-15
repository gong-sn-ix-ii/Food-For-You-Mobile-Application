// ignore_for_file: file_names, unused_import, implementation_imports, unnecessary_import, camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Scan_QRCODE extends StatefulWidget {
  const Scan_QRCODE({super.key});

  @override
  State<Scan_QRCODE> createState() => _Scan_QRCODEState();
}

String? scan_result;

class _Scan_QRCODEState extends State<Scan_QRCODE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("SCAN QRCODE\t\t\t\t\t\t\t\t\t")],
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Card(
          elevation: 5,
          child: ListTile(
            leading: Text("SCAN RESULT :"),
            title: Text(scan_result ??= "ยังไม่มีข้อมูล"),
            trailing: IconButton(
                onPressed: () async {
                  //start_Scanner();
                },
                icon: Icon(Icons.camera_alt_outlined)),
          ),
        ),
      ),
    );
  }

  /*Future<String> start_Scanner() async {
    String? cameraScanQrcodeResult = await scanner.scan();
    return cameraScanQrcodeResult.toString();
  }*/
}
