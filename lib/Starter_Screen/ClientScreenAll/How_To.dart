// ignore_for_file: unnecessary_import, implementation_imports, file_names, camel_case_types, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class How_To_Client extends StatefulWidget {
  const How_To_Client({super.key});

  @override
  State<How_To_Client> createState() => _How_To_ClientState();
}

class _How_To_ClientState extends State<How_To_Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("back"),
      ),
      body: ListView(children: [
        Row(
          children: [
            Container(
              child: Image.asset('assets/image_use/1.png'),
            )
          ],
        ),
      ]),
    );
  }
}
