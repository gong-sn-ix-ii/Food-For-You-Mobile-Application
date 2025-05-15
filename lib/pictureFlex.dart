// ignore_for_file: unnecessary_import, implementation_imports, unused_import, camel_case_types, file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/main.dart';

class pictureFlex extends StatefulWidget {
  const pictureFlex({Key? key}) : super(key: key);

  @override
  State<pictureFlex> createState() => _pictureFlexState();
}

class _pictureFlexState extends State<pictureFlex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/chicken.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ไก่ชุบแป้งทอด',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/salmon.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ปลาแซลม่อนย่างเนย',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/steakwagil1.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'เสต็กวากิล',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/crab1.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ปูนึ่งมะนาว',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/fishgraphong1.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ปลากระพงราดน้ำปลา',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/dragon_shirmp1.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'กุ้งมังกรย่างชีส',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/yum1.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ยำทะเล',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/padgrapao1.jpg',
                      width: 180,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'ผัดกระเพรา',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                SizedBox(
                  width: 350,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[500])),
                    child: Text('ยืนยันการทำรายการ'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
