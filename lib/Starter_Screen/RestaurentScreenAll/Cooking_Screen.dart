// ignore_for_file: unused_import, avoid_web_libraries_in_flutter, implementation_imports, unnecessary_import, camel_case_types, prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, unused_local_variable, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, await_only_futures, use_build_context_synchronously

import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Cooking_Screen extends StatefulWidget {
  List<FoodModel> foodmenu;
  List<int> count_foodmenu;
  String userID;
  int id;
  int money_result;
  Cooking_Screen({
    required this.foodmenu,
    required this.count_foodmenu,
    required this.money_result,
    required this.userID,
    required this.id,
  });
  @override
  State<Cooking_Screen> createState() => _Cooking_ScreenState();
}

class _Cooking_ScreenState extends State<Cooking_Screen> {
  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Cooking Screen คิวที่ ${widget.id}"),
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
                  Icons.fastfood,
                  color: Color.fromARGB(255, 255, 168, 38),
                  size: 60,
                )),
                SizedBox(
                  height: 50,
                ),
                JumpingText(
                  "กำลังทำอาหาร...",
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
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => Comeback_Screen());
                              List<Map<String, dynamic>>? foodlist_order = [];
                              String date = DateTime.now().day.toString() +
                                  "/" +
                                  DateTime.now().month.toString() +
                                  "/" +
                                  DateTime.now().year.toString();

                              String time = DateTime.now().hour.toString() +
                                  ":" +
                                  DateTime.now().minute.toString();
                              List<FoodListModel> len =
                                  await db.get_FoodListAll();
                              int id = await len.length + 1;
                              String uid = "";
                              String text =
                                  "AaBbCCDDEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
                              for (int i = 0; i < 16; i++) {
                                //Round => index
                                int x =
                                    Random().nextInt(text.length); //Random X
                                uid += text.substring(x, x + 1);
                              }
                              setState(() {
                                print(
                                    "FoodModel = ${widget.foodmenu[0].food_name} |\n count = ${widget.count_foodmenu} |\n money_result = ${widget.money_result}.00 THB");
                              });
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
                              await db.add_FoodList(newFoodlistModel, uid);
                              //Navigator.pop(context, "cancle");
                              String my_uid = await db.my_uid();
                              await db.update_Database(
                                  collection_start: "user",
                                  collection_end: "order",
                                  user_ID: widget.userID,
                                  field: "status",
                                  value: "complete",
                                  typeString: true);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => SaveData_Success());
                              Future.delayed(
                                Duration(seconds: 3),
                                () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Main_ScreenRestaurant()),
                                    (route) => false),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.check,
                                    color: Color.fromARGB(255, 60, 255, 66),
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "เสร็จสิ้น",
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
                            onPressed: () async {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => Cancle_Screen());
                              await db.update_Database(
                                  collection_start: "user",
                                  collection_end: "order",
                                  user_ID: widget.userID,
                                  field: "status",
                                  value: "complete",
                                  typeString: true);
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
                                () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Main_ScreenRestaurant()),
                                    (route) => false),
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
                            )),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}

class Comeback_Screen extends StatefulWidget {
  const Comeback_Screen({super.key});

  @override
  State<Comeback_Screen> createState() => _Comeback_ScreenState();
}

class _Comeback_ScreenState extends State<Comeback_Screen> {
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
                "กำลังบันทึกข้อมูล...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SaveData_Success extends StatefulWidget {
  const SaveData_Success({super.key});

  @override
  State<SaveData_Success> createState() => _SaveData_SuccessState();
}

class _SaveData_SuccessState extends State<SaveData_Success> {
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
                "เสร็จเรียบร้อย",
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
