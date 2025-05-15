// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, must_be_immutable, unnecessary_import, unused_import, implementation_imports, file_names, override_on_non_overriding_member, annotate_overrides, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print, dead_code, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_call_super, avoid_unnecessary_containers, await_only_futures, deprecated_member_use, use_build_context_synchronously, camel_case_types, division_optimization, missing_required_param, prefer_is_empty, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Cooking_Screen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddCapital.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestShowTopsell.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/models/makeList_Models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MakeFoodList extends StatefulWidget {
  int id;
  MakeFoodList(this.id);

  @override
  State<MakeFoodList> createState() => _MakeFoodListState();
}

class _MakeFoodListState extends State<MakeFoodList> {
  @override
  Database db = Database.instance;
  int money_sum = 0;
  List<int> count = [1];
  Future<void> get_Money() async {
    MakeListModel money_price;
    money_price = await db.get_MakeList(id: widget.id);
    for (var i = 0; i < money_price.makelist_order.length; i++) {
      int x = money_price.makelist_order[i]["price"];
      money_sum += x;
      print(
          "get_Money => ${money_price.makelist_order[i]["price"]} | moneySum => ${money_sum}");
    }
    setState(() {});
  }

  @override
  void dispose() {
    //ถ้าออกจากหน้าเพิ่มลบจำนวนอาหาร ต้อง Delete ไฟล์เก่าด้วย เช่นสร้าง defualt0 ถ้าออกจากหน้านี้ก็ต้องลบ defualt0
    Future.delayed(Duration.zero, () async {
      String my_uid = await db.my_uid();
      String path = "/user/${my_uid}/makeList/defualt${widget.id}";
      await db.delete_Database(path: path);
    });
    super.dispose();
  }

  void initState() {
    // for (var i = 0; i < widget.savingInformation.length - 1; i++) {
    //   count.add(1);
    // }
    get_Money();
    Future.delayed(Duration.zero, () async {
      MakeListModel makeListModel = await db.get_MakeList(id: widget.id);
      for (var i = 0; i < makeListModel.makelist_order.length; i++) {
        count.add(1);
      }
      setState(() {});
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 10), () {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 20), () {
      setState(() {});
    });
    Future.delayed(Duration(seconds: 30), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<MakeListModel>(
          future: db.get_MakeList(id: widget.id.toInt()),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 7.2 / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 3.5 / 2,
                          child: Card(
                            color: Color.fromARGB(255, 255, 140, 24),
                            elevation: 10,
                            child: InkWell(
                              splashColor: Colors.amber[100],
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 185,
                                height: 70,
                                child: Column(
                                  children: [
                                    Text(
                                      'เฉลี่ยราคา ',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${(money_sum / count.length).toInt()} THB',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 3.5 / 2,
                          child: Card(
                            color: Color.fromARGB(255, 0, 255, 81),
                            elevation: 10,
                            child: InkWell(
                              splashColor: Colors.greenAccent[100],
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 185,
                                height: 70,
                                child: Column(
                                  children: [
                                    Text(
                                      'ราคาสุทธิ',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${money_sum} THB',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: snapshot.data?.makelist_order.length,
                        itemBuilder: (context, index) {
                          return AspectRatio(
                            aspectRatio: 9 / 2,
                            child: Card(
                              elevation: 5,
                              child: InkWell(
                                splashColor: Colors.orange.withOpacity(0.5),
                                child: Container(
                                  width: 200,
                                  height: 70,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10,
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    15,
                                                10,
                                                10),
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          18,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data?.makelist_order[index]["name"]}",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "ราคา : ${snapshot.data?.makelist_order[index]["price"]}.00 THB",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            24),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "จำนวน",
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              15,
                                                      height: 40,
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: null,
                                                        backgroundColor:
                                                            Colors.red,
                                                        onPressed: () async {
                                                          int? coin = await snapshot
                                                                  .data
                                                                  ?.makelist_order[
                                                              index]["price"];
                                                          setState(() {
                                                            print(
                                                                "Click Decrease [Coin]===> ${coin}");
                                                            if (count[index] <=
                                                                1) {
                                                              count[index] = 1;
                                                            } else {
                                                              count[index]--;
                                                              money_sum -=
                                                                  coin!;
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          "-",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                  Card(
                                                    shadowColor: Colors.black,
                                                    child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            15,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            15,
                                                        child: Center(
                                                            child: Text(
                                                          "${count[index]}",
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))),
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              15,
                                                      height: 40,
                                                      child:
                                                          FloatingActionButton(
                                                        heroTag: null,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                71, 216, 75),
                                                        onPressed: () async {
                                                          int? coin =
                                                              await snapshot
                                                                  .data
                                                                  ?.makelist_order[
                                                                      index]
                                                                      ["price"]
                                                                  ?.toInt();
                                                          setState(() {
                                                            print(
                                                                "Coin = ${coin}");
                                                            count[index]++;
                                                            money_sum += coin!;
                                                            print(
                                                                "money Sum ==> ${money_sum}");
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              16,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ),
                          );
                        }),
                  ),
                  Flexible(
                      flex: 0,
                      child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) => Waiting_Screen());
                            List<FoodModel> foodmenu_connection = [];
                            for (var i = 0;
                                i < snapshot.data!.makelist_order.length;
                                i++) {
                              foodmenu_connection.addAll([
                                FoodModel(
                                  food_name: snapshot.data?.makelist_order[i]
                                      ["name"],
                                  food_type: snapshot.data?.makelist_order[i]
                                      ["type"],
                                  food_image: snapshot.data?.makelist_order[i]
                                      ["image"],
                                  food_linkImage: snapshot
                                      .data?.makelist_order[i]["linkImage"],
                                  food_price: snapshot.data?.makelist_order[i]
                                      ["price"],
                                )
                              ]);
                            }
                            // await GetSelectFood(
                            //     widget.savingInformation.length);
                            print(
                                "################## Click accept Check date  ${foodmenu_connection} | ${count} | ${money_sum}");
                            String masterID = await db.my_uid();
                            List<NotificationModel> len =
                                await db.get_DataInside_Collection_Order(
                                    master_ID:
                                        masterID); //data have 3  | format 0 1 2
                            print(
                                "################----------------->>>>>>>>> ${len.length}");
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
                            print("########################### id ${id}|");
                            List<Map<String, dynamic>> foodlist_order = [];
                            for (int i = 0;
                                i < foodmenu_connection.length;
                                i++) {
                              foodlist_order.add({
                                "name": foodmenu_connection[i].food_name,
                                "price": foodmenu_connection[i].food_price,
                                "count": count[i],
                              });
                            }
                            String time2 = DateTime.now().hour.toString() +
                                ":" +
                                DateTime.now().minute.toString();
                            FoodListModel newNotification = await FoodListModel(
                              foodlist_order: foodlist_order,
                              total: money_sum,
                              time: time2,
                              date: date,
                              id: await id,
                            );
                            Service asd = Service.instance;
                            String generate_UID = asd.get_UID(index: 28);
                            db.add_notification(newNotification,
                                master_id: await masterID,
                                doc_id: generate_UID,
                                collection_inside: "order",
                                status: "accept");
                            setState(() {});
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCapitalAndShow()),
                                (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              onSurface: Colors.black,
                              backgroundColor: Color.fromARGB(255, 52, 255, 7)),
                          child: Container(
                            width: 200,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart_checkout_rounded),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "ยืนยัน",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ))),
                ],
              );
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitPouringHourGlass(color: Colors.amber),
                SizedBox(
                  height: 20,
                ),
                JumpingText(
                  "  กำลังทำรายการ... ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                )
              ],
            ));
          }),
    );
  }
}

class Waiting_Screen extends StatefulWidget {
  const Waiting_Screen({super.key});

  @override
  State<Waiting_Screen> createState() => _Waiting_ScreenState();
}

class _Waiting_ScreenState extends State<Waiting_Screen> {
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
                "กำลังทำรายการ...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }
}
