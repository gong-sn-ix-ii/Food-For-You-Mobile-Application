// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, must_be_immutable, unnecessary_import, unused_import, implementation_imports, file_names, override_on_non_overriding_member, annotate_overrides, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print, dead_code, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_call_super, avoid_unnecessary_containers, await_only_futures, deprecated_member_use, use_build_context_synchronously, camel_case_types, division_optimization, missing_required_param

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/Client_waitAllow.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Cooking_Screen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestShowTopsell.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Client_preSendOrder extends StatefulWidget {
  List<String> savingInformation;
  String masterID;
  Client_preSendOrder(this.savingInformation, {required this.masterID});

  @override
  State<Client_preSendOrder> createState() => _Client_preSendOrderState();
}

class _Client_preSendOrderState extends State<Client_preSendOrder> {
  @override
  Database db = Database.instance;
  int money_sum = 0;
  List<int> count = [1];
  Future<void> get_Money(int index) async {
    List<FoodModel> money_price = [];
    money_price = await GetSelectFood(index);
    for (var i = 0; i < index; i++) {
      money_sum += money_price[i].food_price!;
      print(
          "get_Money => ${money_price[i].food_price} | moneySum => ${money_sum}");
    }
    setState(() {});
  }

  void initState() {
    for (var i = 0; i < widget.savingInformation.length - 1; i++) {
      count.add(1);
    }
    get_Money(widget.savingInformation.length);
    super.initState();
  }

  Future<List<FoodModel>> GetSelectFood(int index) async {
    List<FoodModel> food = [];
    for (int i = 0; i < index; i++) {
      food.addAll(await db.Search_FoodmenuForData(
          search: widget.savingInformation[i], masterID: widget.masterID));
      print("Loop In Function GetSelectFood Class Rest_MakeList ==> ${food}");
    }
    return food;
    print(food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${firebaseAuth.currentUser?.email}"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<FoodModel>>(
          future: GetSelectFood(widget.savingInformation.length),
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
                        itemCount: widget.savingInformation.length,
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
                                                "${snapshot.data?[index].food_name}",
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
                                                "ราคา : ${snapshot.data?[index].food_price}.00 THB",
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
                                                          int? coin =
                                                              await snapshot
                                                                  .data?[index]
                                                                  .food_price;
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
                                                                  .data?[index]
                                                                  .food_price
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
                        List<FoodModel> foodmenu_connection =
                            await GetSelectFood(
                                widget.savingInformation.length);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Client_waitAllowOrder(
                                foodmenu: foodmenu_connection,
                                count_foodmenu: count,
                                money_result: money_sum,
                                masterID: widget.masterID,
                              ),
                            ),
                            (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          onSurface: Colors.black,
                          backgroundColor: Color.fromARGB(255, 7, 255, 73)),
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
                              "สรุปรายการ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
