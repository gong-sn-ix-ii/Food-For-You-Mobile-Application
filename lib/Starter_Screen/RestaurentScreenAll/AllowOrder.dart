// ignore_for_file: unnecessary_import, file_names, implementation_imports, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, unused_element, sort_child_properties_last, must_be_immutable, prefer_final_fields, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, unnecessary_null_comparison, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, override_on_non_overriding_member, annotate_overrides, unused_import, non_constant_identifier_names, camel_case_types, unnecessary_string_interpolations, prefer_is_empty, unused_field, use_build_context_synchronously, curly_braces_in_flow_control_structures, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Cooking_Screen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/cospital_model.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AllowOrder_byRestaurant extends StatefulWidget {
  String userID;
  AllowOrder_byRestaurant({required this.userID});
  @override
  State<AllowOrder_byRestaurant> createState() =>
      _AllowOrder_byRestaurantState();
}

class _AllowOrder_byRestaurantState extends State<AllowOrder_byRestaurant> {
  @override
  String masterID = "";
  void initState() {
    Future.delayed(Duration.zero, () async {
      masterID = await db.my_uid();
      setState(() {});
    });
    super.initState();
    print("Initstate ===> ${widget.userID}");
  }

  @override
  final auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                print('Going To MainScreen Restaurant');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Main_ScreenRestaurant()));
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
              ),
              label: Text('')),
        ),
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
      body: StreamBuilder<List<NotificationModel>>(
        stream: db.get_Notification_versionStream_CanSearching(
            master_ID: masterID,
            user_ID: widget.userID,
            collection_Inside: "notificationMessagerToUser"),
        builder: (context, snapshot) {
          print("Snapshot.data.length == 0 ? ${snapshot.data?.length}");
          if (snapshot.data?.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.data_usage_sharp,
                    size: 50,
                    color: Color.fromARGB(255, 206, 206, 206),
                  ),
                  Text(
                    "ไม่พบข้อมูล",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          } else if (snapshot.data?.length != null) {
            return Column(
              children: [
                Flexible(
                  flex: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Card(
                      elevation: 5,
                      child: InkWell(
                        splashColor: Colors.black26,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          width: 330,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 0,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "สั่งออนไลน์ผ่านแอพลิเคชั่น",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "UID : ",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data?[0].userID}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Status : ",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data?[0].status}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ID : ",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data?[0].id}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Date : ",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data?[0].date}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Time : ",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data?[0].time}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Total : ",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${snapshot.data?[0].total}.00 THB",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: snapshot.data?[0].order.length,
                      itemBuilder: (context, index) {
                        IconData set_icon;
                        Color set_color;
                        return Slidable(
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              flex: 20,
                              onPressed: (context) async {},
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ]),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Card(
                              elevation: 5,
                              child: InkWell(
                                splashColor: Colors.black26,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: 500,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 0,
                                        child: ListTile(
                                          leading: Text(
                                            "${index + 1}",
                                            style: TextStyle(
                                                fontSize:
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        15)),
                                          ),
                                          title: Text(
                                            "ชื่อเมนู ${snapshot.data?[0].order[index]["name"]}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            "ชิ้นละ ${snapshot.data?[0].order[index]["price"]}.00THB  \nราคารวม ${snapshot.data?[0].order[index]["price"] * snapshot.data?[0].order[index]["count"]}.00THB",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          trailing: Text(
                                            "x ${snapshot.data?[0].order[index]["count"]}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Flexible(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 255, 8)),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => Comeback_Screen());
                          String my_uid = await db.my_uid();
                          await db.update_Database(
                            collection_start: "user",
                            collection_end: "order",
                            user_ID: widget.userID,
                            field: "status",
                            value: "accept",
                            typeString: true,
                          );
                          String? master_id =
                              snapshot.data?[0].userID.toString();
                          await db.delete_Database(
                              path:
                                  "/user/${my_uid}/notificationMessagerToUser/${master_id}");
                          showDialog(
                              context: context,
                              builder: (context) => SaveData_Success());
                          Future.delayed(Duration(seconds: 3), () async {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Main_ScreenRestaurant()),
                                (route) => false);
                          });
                        }, //Button Accept

                        child: Text(
                          "ยอมรับ",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 20,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 0, 0)),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => Cancle_Screen());
                          String? master_id =
                              snapshot.data?[0].userID.toString();
                          print(
                              "Button Cancle Order  userID ====> ${master_id}");
                          await db.update_Database(
                              collection_start: "user",
                              collection_end: "notificationMessagerToUser",
                              user_ID: master_id.toString(),
                              field: "status",
                              value: "cancle",
                              typeString: true);
                          await db.update_Database(
                              collection_start: "user",
                              collection_end: "order",
                              user_ID: widget.userID,
                              field: "status",
                              value: "cancle",
                              typeString: true);
                          showDialog(
                              context: context,
                              builder: (context) => Cancle_screenComplete());
                          Future.delayed(Duration(seconds: 2), () async {
                            String my_uid = await db.my_uid();
                            await db.delete_Database(
                                path:
                                    "/user/${my_uid}/notificationMessagerToUser/${master_id}");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Main_ScreenRestaurant()),
                                (route) => false);
                          });
                        }, //Button Remove
                        child: Text(
                          "ปฏิเสธ",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 20,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Loading Data...",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
