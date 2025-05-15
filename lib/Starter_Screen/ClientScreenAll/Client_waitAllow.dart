// ignore_for_file: unused_import, avoid_web_libraries_in_flutter, implementation_imports, unnecessary_import, camel_case_types, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, unused_local_variable, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, await_only_futures, use_build_context_synchronously, missing_required_param, prefer_is_empty

import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/Client_AcceptOrCancle.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/services/Database.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Client_waitAllowOrder extends StatefulWidget {
  List<FoodModel> foodmenu;
  List<int> count_foodmenu;
  int money_result;
  String masterID;
  Client_waitAllowOrder(
      {required this.foodmenu,
      required this.count_foodmenu,
      required this.money_result,
      required this.masterID});
  @override
  State<Client_waitAllowOrder> createState() => _Client_waitAllowOrderState();
}

class _Client_waitAllowOrderState extends State<Client_waitAllowOrder> {
  String restaurant_uid = "";
  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Cooking Screen"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 1, child: Container()),
            Column(
              children: [
                HeartbeatProgressIndicator(
                    child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color.fromARGB(255, 26, 255, 0),
                  size: 70,
                )),
                SizedBox(
                  height: 50,
                ),
                JumpingText(
                  "สั่งซื้อตอนนี้เลยไหม?",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
              thickness: 4,
            ),
            Flexible(
              flex: 2,
              child: ListView.builder(
                  itemCount: widget.foodmenu.length,
                  itemBuilder: (context, index) => Container(
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              "${widget.foodmenu[index].food_name}",
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                                "ประเภท : ${widget.foodmenu[index].food_type} ราคา : ${widget.foodmenu[index].food_price! * widget.count_foodmenu[index]}.00THB"),
                            trailing: Text(
                              "x${widget.count_foodmenu[index]}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )),
            ),
            Flexible(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    style: BorderStyle.solid, width: 2)),
                            onPressed: () async {
                              print("Click Buy");
                              List<Map<String, dynamic>>? foodlist_order = [];
                              String date = DateTime.now().day.toString() +
                                  "/" +
                                  DateTime.now().month.toString() +
                                  "/" +
                                  DateTime.now().year.toString();

                              String time = DateTime.now().hour.toString() +
                                  ":" +
                                  DateTime.now().minute.toString();
                              List<NotificationModel> len =
                                  await db.get_DataInside_Collection_Order(
                                      master_ID: widget.masterID);

                              int id = 0;
                              if (len.length <= 0) {
                                id = 1;
                              } else {
                                for (var i = 0; i < len.length; i++) {
                                  if (id <= len[i].id) {
                                    id = len[i].id;
                                  }
                                }
                                id += 1;
                              }
                              print(
                                  "########################## ${len.length} ############ ID-OLD ${id - 1} ###### New ${id}");
                              String uid = "";
                              String text =
                                  "AaBbCCDDEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
                              for (int i = 0; i < 16; i++) {
                                //Round => index
                                int x =
                                    Random().nextInt(text.length); //Random X
                                uid += text.substring(x, x + 1);
                              }
                              print(
                                  "FoodModel = ${widget.foodmenu[0].food_name} |\n count = ${widget.count_foodmenu} |\n money_result = ${widget.money_result}.00 THB");

                              print(
                                  "######### Length ===> ${widget.foodmenu.length} ");
                              for (int i = 0; i < widget.foodmenu.length; i++) {
                                print(
                                    "[${i}].Foodmenu => ${widget.foodmenu[i].food_name} | ${widget.foodmenu[i].food_price} | count = ${widget.count_foodmenu[i]}");
                                foodlist_order.add({
                                  "name": widget.foodmenu[i].food_name,
                                  "price": widget.foodmenu[i].food_price,
                                  "count": widget.count_foodmenu[i]
                                });
                              }
                              print(
                                  " ###################### foodlist_order Variable ==> ${foodlist_order}");
                              FoodListModel newFoodlistModel = FoodListModel(
                                  foodlist_order: foodlist_order,
                                  total: widget.money_result,
                                  date: date,
                                  time: time,
                                  id: id);
                              String doc_id = await db.my_uid();
                              await db.add_notification(newFoodlistModel,
                                  master_id: widget.masterID,
                                  doc_id: doc_id,
                                  collection_inside:
                                      "notificationMessagerToUser");
                              await db.add_notification(newFoodlistModel,
                                  master_id: widget.masterID,
                                  doc_id: doc_id,
                                  collection_inside: "order");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Accept_Or_Cancle(
                                            master_ID: widget.masterID,
                                          )),
                                  (route) => false);
                            },
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.shopping_cart_checkout_outlined,
                                    color: Color.fromARGB(255, 0, 234, 8),
                                    size: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "สั่งซื้อ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                  style: BorderStyle.solid, width: 2)),
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => Cancle_Screen());
                            Future.delayed(
                              Duration(seconds: 2),
                              () => showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => Cancle_screenComplete(),
                              ),
                            );

                            Future.delayed(
                              Duration(seconds: 5),
                              () {
                                return Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Client_Menu()),
                                    (route) => false);
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 00, 0),
                                  child: Text(
                                    "x",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.red),
                                  )),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                child: Text(
                                  "ยกเลิก",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}

class WaitSendOrderToRestaurant extends StatefulWidget {
  const WaitSendOrderToRestaurant({super.key});

  @override
  State<WaitSendOrderToRestaurant> createState() =>
      _WaitSendOrderToRestaurantState();
}

class _WaitSendOrderToRestaurantState extends State<WaitSendOrderToRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: null,
          title: Column(
            children: [
              CircularProgressIndicator(
                color: Colors.amber,
              ),
              SizedBox(
                height: 30,
              ),
              JumpingText(
                "กำลังสั่งซื้ออาหาร...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WaitAllow_Success extends StatefulWidget {
  const WaitAllow_Success({super.key});

  @override
  State<WaitAllow_Success> createState() => _WaitAllow_SuccessState();
}

class _WaitAllow_SuccessState extends State<WaitAllow_Success> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: null,
          title: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Color.fromARGB(255, 0, 255, 8),
              ),
              SizedBox(
                height: 20,
              ),
              JumpingText(
                "คำสั่งซื้อถูกส่งเรียบร้อย",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Cancle_Screen extends StatefulWidget {
  const Cancle_Screen({super.key});

  @override
  State<Cancle_Screen> createState() => _Cancle_ScreenState();
}

class _Cancle_ScreenState extends State<Cancle_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: null,
          title: Column(
            children: [
              CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 7, 7),
              ),
              SizedBox(
                height: 30,
              ),
              JumpingText(
                "กำลังยกเลิกคำสั่งซิื้อ...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Cancle_screenComplete extends StatefulWidget {
  const Cancle_screenComplete({super.key});

  @override
  State<Cancle_screenComplete> createState() => _Cancle_screenCompleteState();
}

class _Cancle_screenCompleteState extends State<Cancle_screenComplete> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AlertDialog(
          backgroundColor: null,
          title: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
              SizedBox(
                height: 20,
              ),
              JumpingText(
                "ยกเลิกเรียบร้อย",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }
}
