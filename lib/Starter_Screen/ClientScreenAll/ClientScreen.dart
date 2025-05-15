// ignore_for_file: file_names ignore_for_file: file_names, unnecessary_import, prefer_const_constructors, unused_import, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, camel_case_types, file_names, sort_child_properties_last, avoid_print, missing_required_param

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodapp/Generate_QRcode.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientOrderMenu.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/Client_FoodOrder.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/How_To.dart';
import 'package:foodapp/TestCode/Test.dart';
import 'package:foodapp/scannerQRCODE.dart';
import 'package:foodapp/services/camera_scanQR.dart';
import 'package:foodapp/widgets/MySingnout.dart';

class Client_Menu extends StatefulWidget {
  const Client_Menu({Key? key}) : super(key: key);

  @override
  State<Client_Menu> createState() => _Client_MenuState();
}

class _Client_MenuState extends State<Client_Menu> {
  final xy = 5.00;
  final auth = FirebaseAuth.instance;
  String urlImg =
      'https://www.sgethai.com/wp-content/uploads/2021/09/spicy-fried-tubtim-fish-salad-spicy-thai-food-1-600x400.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          child: Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              Text(
                '${auth.currentUser?.email}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(65, 0, 0, 25)),
                Icon(
                  Icons.attach_money,
                  size: 20,
                  color: Colors.yellow,
                ),
                Text(
                  '00.00 THB',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/images/s_152711_9495.jpg',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 15,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 50,
                0, MediaQuery.of(context).size.width / 50, 0),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    elevation: 15,
                    side: BorderSide(width: 2),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Foodmenu_order()));
                },
                icon: Icon(
                  Icons.note_alt_outlined,
                  size: MediaQuery.of(context).size.width / 10,
                ),
                label: Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 20,
                      MediaQuery.of(context).size.width / 30,
                      MediaQuery.of(context).size.width / 20,
                      MediaQuery.of(context).size.width / 30),
                  child: Text(
                    "สั่งอาหาร",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 50,
                    0,
                    MediaQuery.of(context).size.width / 50,
                    0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        side: BorderSide(width: 2),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRViewExample()));
                    },
                    icon: Icon(
                      Icons
                          .qr_code_scanner_outlined, //qr_code_scanner_rounded | settings_overscan
                      size: MediaQuery.of(context).size.width / 15,
                    ),
                    label: Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 50,
                          MediaQuery.of(context).size.width / 40,
                          MediaQuery.of(context).size.width / 50,
                          MediaQuery.of(context).size.width / 40),
                      child: Text(
                        "สแกน QRCODE",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 6,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 100,
                    0,
                    MediaQuery.of(context).size.width / 100,
                    0),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        elevation: 15,
                        side: BorderSide(width: 2),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Generate_QRCODE()));
                    },
                    icon: Icon(
                      Icons.qr_code_2_outlined,
                      size: MediaQuery.of(context).size.width / 15,
                    ),
                    label: Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 25,
                          MediaQuery.of(context).size.width / 40,
                          MediaQuery.of(context).size.width / 20,
                          MediaQuery.of(context).size.width / 40),
                      child: Text(
                        "สร้าง QR",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ],
          ),
          Divider(
            height: MediaQuery.of(context).size.width / 10,
            thickness: 5,
            color: Colors.black,
            indent: MediaQuery.of(context).size.width / 40,
            endIndent: MediaQuery.of(context).size.width / 40,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(MediaQuery.of(context).size.width / 10)),
            ),
            child: Image(
              image: NetworkImage(
                  "https://images.squarespace-cdn.com/content/v1/53b839afe4b07ea978436183/1608506169128-S6KYNEV61LEP5MS1UIH4/traditional-food-around-the-world-Travlinmad.jpg"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(13),
            child: Text(
              'เมนูแนะนำ',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 0, 0),
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              children: [
                Material(
                  color: Colors.orange[400],
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.white54,
                    onTap: () {},
                    child: Column(
                      children: [
                        Ink.image(
                          image: NetworkImage(urlImg),
                          height: 80,
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'ปลาทอด',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
                Material(
                  color: Colors.orange[400],
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.white54,
                    onTap: () {},
                    child: Column(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                              'https://s.isanook.com/tr/0/rp/rc/w850h510/yatxacm1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL3RyLzAvdWQvMjg0LzE0MjM4NDUvZ2h5LmpwZw==.jpg'),
                          height: 80,
                          width: 112,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'ผัดกระเพรา',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
                Material(
                  color: Colors.orange[400],
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    splashColor: Colors.white54,
                    onTap: () {},
                    child: Column(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                              'https://img.kapook.com/u/2018/sutasinee/03/p700.jpg'),
                          height: 80,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'ทะเลย่าง',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      drawer: Drawer(
        child: MySignOut(),
      ),
    );
  }
}
