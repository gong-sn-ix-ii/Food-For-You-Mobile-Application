// ignore_for_file: unnecessary_import, file_names, implementation_imports, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, unused_element, sort_child_properties_last, must_be_immutable, prefer_final_fields, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, unnecessary_null_comparison, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, override_on_non_overriding_member, annotate_overrides, unused_import, non_constant_identifier_names, prefer_is_empty, await_only_futures, use_build_context_synchronously, missing_required_param, dead_code, unnecessary_string_interpolations

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/Client_preSendOrder.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/AllowOrder.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Cooking_Screen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/TimesetModel.dart';
import 'package:foodapp/models/cospital_model.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AddCapitalAndShow extends StatefulWidget {
  const AddCapitalAndShow({Key? key}) : super(key: key);

  @override
  State<AddCapitalAndShow> createState() => _AddCapitalAndShowState();
}

class _AddCapitalAndShowState extends State<AddCapitalAndShow> {
  @override
  String my_uid = "";
  String master_ID = "";
  Service sv = Service.instance;
  TimesetModel? timeset =
      TimesetModel(time_Open: "21014.6", time_Close: "20094.5");
  bool waitData = false;
  double rateTimingBeforeDelete = 0.60;
  void initState() {
    Future.delayed(Duration.zero, () async {
      my_uid = await db.my_uid();
      master_ID = await db.my_uid();
      print("#####################################----Initstate ${my_uid}");
      setState(() {});
    });
    setState(() {});
    Future.delayed(Duration(minutes: 60), () async {
      waitData = true;
      //True False แบบกำหนดไว้เลย อนาคตอยากให้เอาเวลาเปิด ปิด ร้านมาเช็คแล้วส่งคืนค่า true false เพราะ true false ตัวนี้กำหนดการลบข้อมูล
      setState(() {});
    });
    setState(() {});
    super.initState();
  }

  List<String> text = [
    "",
    "",
    "",
    "",
    "",
  ]; // 0 = index | 1 = dateTime | 2 = detail | 3 = queue | 4 = moreDetail |
  Color colors_name = Colors.black,
      queue = Color.fromARGB(255, 255, 17, 0),
      more = Color.fromARGB(255, 0, 255, 8),
      todayTime = Color.fromARGB(255, 255, 187, 0),
      color_Leading = Colors.black,
      card_Background = Colors.white;
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
                    '${sv.Generate_DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year, del_value: 12)}',
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
        body: Column(
          children: [
            Flexible(
              child: StreamBuilder<TimesetModel>(
                stream: db.get_TimesetOpenClose(master_UID: master_ID),
                builder: (context, second_Snapshot) {
                  double? timeset_TimeOpen = double.tryParse(
                      second_Snapshot.data?.time_Open ?? "00.00");
                  double? timeset_TimeClose = double.tryParse(
                      second_Snapshot.data?.time_Close ?? "00.00");
                  double? timeNow = double.tryParse(
                      DateTime.now().hour.toString() +
                          "." +
                          DateTime.now().minute.toString());
                  if (timeset_TimeOpen! > timeset_TimeClose!) {
                    if (timeNow! < timeset_TimeOpen &&
                        timeNow > timeset_TimeClose) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 255, 141, 141),
                              Color.fromARGB(255, 255, 0, 0),
                            ])),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ร้านปิดทำการอยู่\n    [${second_Snapshot.data?.time_Open ?? "00.00"} - ${second_Snapshot.data?.time_Close ?? "00.00"}]",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 141, 255, 141),
                            Color.fromARGB(255, 0, 255, 0),
                          ]),
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ร้านเปิดทำการอยู่\n    [${second_Snapshot.data?.time_Open ?? "00.00"} - ${second_Snapshot.data?.time_Close ?? "00.00"}]",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    if (timeNow! < timeset_TimeOpen ||
                        timeNow > timeset_TimeClose) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 255, 141, 141),
                              Color.fromARGB(255, 255, 0, 0),
                            ])),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ร้านปิดทำการอยู่\n    [${second_Snapshot.data?.time_Open ?? "00.00"} - ${second_Snapshot.data?.time_Close ?? "00.00"}]",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 141, 255, 141),
                              Color.fromARGB(255, 0, 255, 0),
                            ])),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "  ร้านเปิดทำการอยู่\n    [${second_Snapshot.data?.time_Open ?? "00.00"} - ${second_Snapshot.data?.time_Close ?? "00.00"}]",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            Flexible(
              flex: 7,
              child: StreamBuilder<List<NotificationModel>>(
                stream: db.get_Notification_versionStream_CanOrderBy(
                    master_ID: my_uid,
                    collection_Inside: "order",
                    desception: false),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "วันนี้ยังไม่มีการทำรายการ",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "(หากร้านอยู่ในสถานะปิดทำการจะไม่สามารถทำรายการได้)",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 27,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.data?.length != null) {
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder<TimesetModel>(
                              stream: db.get_TimesetOpenClose(
                                  master_UID: master_ID),
                              builder: (context, third_snapshot) {
                                double? timeNow = double.tryParse(
                                    DateTime.now().hour.toString() +
                                        "." +
                                        DateTime.now().minute.toString());

                                bool time_conditionOpenGreathanClose = false;

                                if (double.tryParse(
                                        third_snapshot.data?.time_Open ??
                                            "00.00")! >
                                    double.tryParse(
                                        third_snapshot.data?.time_Close ??
                                            "00.00")!) {
                                  time_conditionOpenGreathanClose = ((timeNow! <
                                          double.tryParse(
                                              third_snapshot.data?.time_Open ??
                                                  "00.00")!) &&
                                      timeNow >
                                          double.tryParse(
                                              third_snapshot.data?.time_Close ??
                                                  "00.00")!);
                                } else {
                                  time_conditionOpenGreathanClose = (timeNow! <
                                          double.tryParse(
                                              third_snapshot.data?.time_Open ??
                                                  "00.00")! ||
                                      timeNow >
                                          double.tryParse(
                                              third_snapshot.data?.time_Close ??
                                                  "00.00")!);
                                }
                                if ((time_conditionOpenGreathanClose != true)) {
                                  //IF ASDASDASDASDASDASDASDAS
                                  if (snapshot.data?[index].status ==
                                      "complete") {
                                    colors_name =
                                        Color.fromARGB(255, 183, 224, 173);
                                    queue = Color.fromARGB(255, 183, 224, 173);
                                    more = Color.fromARGB(255, 183, 224, 173);
                                    todayTime =
                                        Color.fromARGB(255, 183, 224, 173);
                                    color_Leading =
                                        Color.fromARGB(255, 183, 224, 173);
                                    card_Background =
                                        Color.fromARGB(255, 221, 255, 223);
                                  } else if (snapshot.data?[index].status ==
                                      "cancle") {
                                    colors_name =
                                        Color.fromARGB(255, 255, 205, 205);
                                    queue = Color.fromARGB(255, 255, 205, 205);
                                    more = Color.fromARGB(255, 255, 205, 205);
                                    todayTime =
                                        Color.fromARGB(255, 255, 205, 205);
                                    color_Leading =
                                        Color.fromARGB(255, 255, 205, 205);
                                    card_Background =
                                        Color.fromARGB(255, 255, 234, 234);
                                  } else if (snapshot.data?[index].status ==
                                      "accept") {
                                    colors_name = Colors.black;
                                    queue = Color.fromARGB(255, 255, 17, 0);
                                    more = Color.fromARGB(255, 0, 255, 8);
                                    todayTime =
                                        Color.fromARGB(255, 255, 187, 0);
                                    color_Leading = Colors.black;
                                    card_Background = Colors.white;
                                  } else {
                                    colors_name =
                                        Color.fromARGB(255, 208, 208, 208);
                                    queue = Color.fromARGB(255, 203, 203, 203);
                                    more = Color.fromARGB(255, 211, 211, 211);
                                    todayTime =
                                        Color.fromARGB(255, 205, 205, 205);
                                    color_Leading =
                                        Color.fromARGB(255, 193, 193, 193);
                                    card_Background =
                                        Color.fromARGB(255, 239, 239, 239);
                                  }
                                  return Slidable(
                                    endActionPane: ActionPane(
                                        motion: ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0)),
                                            flex: 20,
                                            onPressed: (context) async {
                                              String? userID =
                                                  snapshot.data?[index].userID;
                                              if (snapshot
                                                      .data?[index].status !=
                                                  "complete") {
                                                await db.update_Database(
                                                    collection_start: "user",
                                                    collection_end: "order",
                                                    user_ID: userID.toString(),
                                                    field: "status",
                                                    value: "accept",
                                                    typeString: true);
                                                await db.delete_Database(
                                                    path:
                                                        "/user/${my_uid}/notificationMessagerToUser/${snapshot.data?[index].userID}");
                                              }
                                            },
                                            backgroundColor:
                                                Color.fromARGB(255, 0, 255, 17),
                                            foregroundColor: Colors.white,
                                            icon: Icons
                                                .check_circle_outline_rounded,
                                            label: 'accept',
                                          ),
                                          SlidableAction(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0)),
                                            flex: 20,
                                            onPressed: (context) async {
                                              String? userID =
                                                  snapshot.data?[index].userID;
                                              if (snapshot
                                                      .data?[index].status !=
                                                  "complete") {
                                                await db.update_Database(
                                                    collection_start: "user",
                                                    collection_end: "order",
                                                    user_ID: userID.toString(),
                                                    field: "status",
                                                    value: "cancle",
                                                    typeString: true);
                                                await db.delete_Database(
                                                    path:
                                                        "/user/${my_uid}/notificationMessagerToUser/${snapshot.data?[index].userID}");
                                              }
                                            },
                                            backgroundColor: Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Icons.cancel_outlined,
                                            label: 'Cancle',
                                          ),
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Card(
                                        color: card_Background,
                                        elevation: 10,
                                        child: InkWell(
                                          splashColor: Colors.black26,
                                          child: ListTile(
                                            leading: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          20,
                                                  fontWeight: FontWeight.bold,
                                                  color: color_Leading),
                                            ),
                                            title: Text(
                                              "${snapshot.data?[index].date} ${snapshot.data?[index].time}น.",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          25,
                                                  fontWeight: FontWeight.bold,
                                                  color: todayTime),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                  "ชื่อเมนู ${snapshot.data?[index].order[0]["name"]}...\nรวม ${snapshot.data?[index].total}.00 THB",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: colors_name),
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              children: [
                                                Text(
                                                  "คิวที่  ${snapshot.data?[index].id}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: queue),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      50,
                                                ),
                                                Text(
                                                  "เพิ่มเติมอีก ${(snapshot.data?[index].order.length)! - 1} รายการ",
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: more),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            if (snapshot.data?[index].status ==
                                                "accept") {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      Waiting_Screen());
                                              int? len = await snapshot
                                                  .data?[index].order.length;
                                              List<FoodModel> foodmenu = [];
                                              List<Map<String, dynamic>> order =
                                                  [];
                                              int? id = await snapshot
                                                  .data?[index].id;
                                              String? userID = await snapshot
                                                  .data?[index].userID;
                                              List<int> count_foodmenu = [];
                                              for (int i = 0; i < len!; i++) {
                                                foodmenu += await db
                                                    .Search_FoodmenuForData(
                                                        search: snapshot
                                                            .data?[index]
                                                            .order[i]["name"]);
                                                count_foodmenu.add(snapshot
                                                    .data?[index]
                                                    .order[i]["count"]);
                                              }
                                              print(
                                                  "############################### ${foodmenu[0].food_name}");
                                              int? sum = await snapshot
                                                  .data?[index].total;
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return Cooking_Screen(
                                                    foodmenu: foodmenu,
                                                    count_foodmenu:
                                                        count_foodmenu,
                                                    money_result: sum!,
                                                    userID: userID!,
                                                    id: id!,
                                                  );
                                                }),
                                              );
                                            } else if (snapshot
                                                    .data?[index].status ==
                                                "wait") {
                                              String? user_uid =
                                                  snapshot.data?[index].userID;
                                              Navigator.pushAndRemoveUntil(
                                                  context, MaterialPageRoute(
                                                      builder: (context) {
                                                String? userID =
                                                    snapshot.data?[0].userID;
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllowOrder_byRestaurant(
                                                                userID: user_uid
                                                                    .toString(),
                                                              )),
                                                      (route) => false);
                                                });
                                                return Container();
                                              }), (route) => false);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  /*my_uid;
                          String? uid_per_order =
                              snapshot.data?[index].userID.toString();
                          print("Else ${uid_per_order}<-------####");
                          String path = "/user/${my_uid}/order/${uid_per_order}";
                          db.delete_Database(path: path);*/
                                  if (waitData) {
                                    return StreamBuilder<TimesetModel>(
                                        stream: db.get_TimesetOpenClose(
                                            master_UID: master_ID),
                                        builder: (context, second_Snapshot) {
                                          double? notify_Time = double.tryParse(
                                              snapshot.data?[index].time ??
                                                  "00.00");
                                          double? timeset_TimeOpen =
                                              double.tryParse(second_Snapshot
                                                      .data?.time_Open ??
                                                  "00.00");
                                          double? timeset_TimeClose =
                                              double.tryParse(second_Snapshot
                                                      .data?.time_Close ??
                                                  "00.00");
                                          double? timeNow = double.tryParse(
                                              DateTime.now().hour.toString() +
                                                  "." +
                                                  DateTime.now()
                                                      .minute
                                                      .toString());
                                          if (timeset_TimeOpen! >
                                              timeset_TimeClose!) {
                                            if (timeNow! < timeset_TimeOpen &&
                                                timeNow > timeset_TimeClose) {
                                              my_uid;
                                              String? uid_per_order = snapshot
                                                  .data?[index].userID
                                                  .toString();
                                              print(
                                                  "Else ${uid_per_order}<-------####");
                                              String path =
                                                  "/user/${my_uid}/order/${uid_per_order}";
                                              db.delete_Database(path: path);
                                              return CircularProgressIndicator(
                                                color: Colors.black,
                                              );
                                            } else {
                                              return Container();
                                            }
                                          } else {
                                            if ((timeNow! < timeset_TimeOpen ||
                                                timeNow > timeset_TimeClose)) {
                                              my_uid;
                                              String? uid_per_order = snapshot
                                                  .data?[index].userID
                                                  .toString();
                                              print(
                                                  "Else ${uid_per_order}<-------####");
                                              String path =
                                                  "/user/${my_uid}/order/${uid_per_order}";
                                              print(
                                                  "##############################################################################RestAddCospital###### 123                            5555");

                                              db.delete_Database(path: path);
                                              return Center(
                                                child: Container(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return CircularProgressIndicator(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              );
                                            }
                                          }
                                        });
                                  } else {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ต้องถึงเวลาเปิดทำการจึงจะมองเห็นออเดอร์\n                            ออเดอร์ ${snapshot.data?[index].id}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black),
                                              onPressed: () async {
                                                my_uid;
                                                String? uid_per_order = snapshot
                                                    .data?[index].userID
                                                    .toString();
                                                print(
                                                    "Else ${uid_per_order}<-------####");
                                                String path =
                                                    "/user/${my_uid}/order/${uid_per_order}";
                                                print(
                                                    "##############################################################################RestAddCospital###### 123                            5555");

                                                await db.delete_Database(
                                                    path: path);
                                              },
                                              child: Icon(
                                                Icons.delete_forever,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    );
                                  }
                                }
                              });
                        });
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
                    ));
                  }
                },
              ),
            ),
          ],
        ));
  }
}
