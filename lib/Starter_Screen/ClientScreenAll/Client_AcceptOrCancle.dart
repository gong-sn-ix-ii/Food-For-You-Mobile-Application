// ignore_for_file: file_names, unnecessary_import, implementation_imports, unused_import, camel_case_types, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, override_on_non_overriding_member, annotate_overrides, prefer_is_empty, avoid_print, dead_code

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestList.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../services/service.dart';

class Accept_Or_Cancle extends StatefulWidget {
  String master_ID;
  Accept_Or_Cancle({required this.master_ID});

  @override
  State<Accept_Or_Cancle> createState() => _Accept_Or_CancleState();
}

class _Accept_Or_CancleState extends State<Accept_Or_Cancle> {
  @override
  String my_UID = "";
  void initState() {
    Future.delayed(Duration.zero, () async {
      my_UID = await db.my_uid();
      print("InitState my_UID = ${my_UID}");
      setState(() {});
    });
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(""),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StreamBuilder<List<NotificationModel>>(
              stream: db.get_Notification_versionStream_CanSearching(
                  master_ID: widget.master_ID,
                  user_ID: my_UID,
                  collection_Inside: "order"),
              builder: (context, snapshot) {
                if (snapshot.data?.length == 0) {
                  return Center(
                      child: Text(
                    "ไม่พบข้อมูล",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontWeight: FontWeight.bold),
                  ));
                } else if (snapshot.data?.length != null) {
                  if (snapshot.data?[0].status == "wait") {
                    return Center(
                      child: Text("กำลังรอการยืนยัน",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 15,
                              fontWeight: FontWeight.bold)),
                    );
                  } else if (snapshot.data?[0].status == "accept") {
                    return Center(
                      child: Column(
                        children: [
                          HeartbeatProgressIndicator(
                              child: Icon(
                            Icons.check_circle_outline,
                            size: MediaQuery.of(context).size.width / 7,
                            color: Color.fromARGB(255, 0, 255, 8),
                          )),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 10,
                          ),
                          JumpingText("ยืนยันออเดอร์เรียบร้อย",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 255, 8))),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 20,
                          ),
                          Card(
                            color: Color.fromARGB(255, 255, 248, 248),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 60,
                              ),
                              child: Text(
                                  "คุณได้คิวที่ ${snapshot.data?[0].id}",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                color: Color.fromARGB(255, 255, 248, 248),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 60,
                                  ),
                                  child: Text(
                                      "วันที่ ${snapshot.data?[0].date}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              17,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                ),
                              ),
                              Card(
                                color: Color.fromARGB(255, 255, 248, 248),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 60,
                                  ),
                                  child: Text(
                                      "เวลา ${snapshot.data?[0].time}:${Random().nextInt(59)}   ",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              17,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 20,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(
                          //       MediaQuery.of(context).size.width / 20),
                          //   width: MediaQuery.of(context).size.width / 1.2,
                          //   height: MediaQuery.of(context).size.width / 1.5,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       gradient: LinearGradient(colors: [
                          //         Colors.white,
                          //         Color.fromARGB(255, 248, 248, 248),
                          //       ])),
                          //   child: Flexible(
                          //       flex: 1,
                          //       child: ListView.builder(
                          //           itemCount: snapshot.data?[0].order.length,
                          //           itemBuilder: (context, index) {
                          //             return Card(
                          //               elevation: 20,
                          //               child: ListTile(
                          //                 leading: Container(
                          //                   padding: EdgeInsets.all(5),
                          //                   child: Text(
                          //                     "${index + 1}",
                          //                     style: TextStyle(
                          //                       fontSize: MediaQuery.of(context)
                          //                               .size
                          //                               .width /
                          //                           25,
                          //                       fontWeight: FontWeight.bold,
                          //                       color: Color.fromARGB(
                          //                           255, 0, 0, 0),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 title: Text(
                          //                   "${snapshot.data?[0].order[index]["name"]}",
                          //                   style: TextStyle(
                          //                     fontSize: MediaQuery.of(context)
                          //                             .size
                          //                             .width /
                          //                         20,
                          //                     fontWeight: FontWeight.bold,
                          //                     color:
                          //                         Color.fromARGB(255, 0, 0, 0),
                          //                   ),
                          //                 ),
                          //                 trailing: Text(
                          //                   "x ${snapshot.data?[0].order[index]["count"]}",
                          //                   style: TextStyle(
                          //                     fontSize: MediaQuery.of(context)
                          //                             .size
                          //                             .width /
                          //                         20,
                          //                     fontWeight: FontWeight.bold,
                          //                     color:
                          //                         Color.fromARGB(255, 0, 0, 0),
                          //                   ),
                          //                 ),
                          //                 subtitle: Text(
                          //                   "ชื้นละ ${snapshot.data?[0].order[index]["price"]}.00 THB\nTotal  ${snapshot.data?[0].order[index]["price"] * snapshot.data?[0].order[index]["count"]}.00 THB",
                          //                   style: TextStyle(
                          //                     fontSize: MediaQuery.of(context)
                          //                             .size
                          //                             .width /
                          //                         30,
                          //                     fontWeight: FontWeight.bold,
                          //                     color: Color.fromARGB(
                          //                         255, 94, 94, 94),
                          //                   ),
                          //                 ),
                          //               ),
                          //             );
                          //           })),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {});
                              Future.delayed(Duration(seconds: 2), () async {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Client_Menu()),
                                    (route) => false);
                              });
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    strokeAlign: StrokeAlign.outside),
                                backgroundColor: Colors.white,
                                elevation: 10),
                            icon: Icon(
                              Icons.next_plan_outlined,
                              size: MediaQuery.of(context).size.width / 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            label: Text(
                              "ไปยังหน้ารายการ",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.data?[0].status == "cancle") {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            "คำสั่งซื้อถูกยกเลิก",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 17, 0)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              setState(() {});
                              Future.delayed(Duration(seconds: 2), () async {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Client_Menu()),
                                    (route) => false);
                              });
                              String my_uid = await db.my_uid();
                              await db.delete_Database(
                                  path:
                                      "/user/${widget.master_ID}/order/${my_uid}");
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    strokeAlign: StrokeAlign.outside),
                                backgroundColor: Colors.white,
                                elevation: 10),
                            icon: Icon(
                              Icons.exit_to_app,
                              size: MediaQuery.of(context).size.width / 15,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                            label: Text(
                              "กลับสู่หน้าหลัก",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 15,
                      ),
                      Text(
                        "กำลังโหลดข้อมูล",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
