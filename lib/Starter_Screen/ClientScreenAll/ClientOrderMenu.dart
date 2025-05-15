// ignore_for_file: file_names, unnecessary_import, implementation_imports, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, unused_local_variable, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_is_empty, unnecessary_brace_in_string_interps, override_on_non_overriding_member, annotate_overrides, unused_import, unused_element, await_only_futures, must_call_super, unused_field, avoid_returning_null_for_void, unnecessary_null_in_if_null_operators, deprecated_member_use, sized_box_for_whitespace, camel_case_types, sort_child_properties_last, must_be_immutable, use_key_in_widget_constructors, invalid_required_named_param, missing_required_param, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/Client_preSendOrder.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddFoodmenu.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Rest_makeList.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/user_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';

class Client_OrderMenu extends StatefulWidget {
  String masterID;
  Client_OrderMenu({@required this.masterID = "null"});

  @override
  State<Client_OrderMenu> createState() => _Client_OrderMenuState();
}

class _Client_OrderMenuState extends State<Client_OrderMenu> {
  @override
  Database db = Database.instance;
  Color? enableButton;
  Future<int> Length() async {
    List<FoodModel> size =
        await db.getAllFoodMenu_Database(masterID: widget.masterID);
    int sized = await size.length;
    return await sized;
  }

  Future<List<FoodModel>> Database_getAllFoodModelDelayedSetTimer(int timer) {
    return Future.delayed(Duration(seconds: timer),
        () => db.getAllFoodMenu_Database(masterID: widget.masterID));
  }

  int x = 0;
  bool? _isEnableActiveButton;
  int check_length = 0, food_count = 0, drink_count = 0, dessert_count = 0;
  List<String>? savingInformation = [];
  List<FoodModel> foodList = [];
  List<bool> check = [false];
  List<bool> menu = [true, false, false, false];
  List<Color> active_colors = [
    Color.fromARGB(255, 114, 255, 59),
    Colors.white,
    Colors.white,
    Colors.white
  ];
  void initState() {
    Future.delayed(Duration.zero, () async {
      int x = await Length();
      foodList = await db.getAllFoodMenu_Database(masterID: widget.masterID);
      for (var i = 1; i < x; i++) {
        print("########################### initState()");
        check.add(false);
      }
      for (var i = 0; i < x; i++) {
        if (foodList[i].food_type == "อาหาร") {
          food_count++;
        } else if (foodList[i].food_type == "เครื่องดื่ม") {
          drink_count++;
        } else if (foodList[i].food_type == "ของหวาน") {
          dessert_count++;
        }
        print(
            "FoodList ==> ${foodList[i].food_name} | Food [${food_count}] Drink[${drink_count}] Dessert [${dessert_count}]");
      }
    });
    // ignore: todo
    // TODO: implement initState
    super.initState();
    print("Checked => ${check}");
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () async {
                String? _email = "null";
                _email = await firebaseAuth.currentUser?.email;
                UserModel user_service = await db.Searching_User(
                    collection: "user",
                    field: "email",
                    equalTo: _email.toString());
                print(
                    "#### ${user_service.mode} | ### ${user_service.email} | #### ${user_service.date} | #### ${user_service.phoneNumber}");
                if (user_service.mode == "service") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Main_ScreenRestaurant()),
                      (route) => false);
                } else if (user_service.mode == "user") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => Client_Menu()),
                      (route) => false);
                }
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
                  "00.00 THB",
                  style: TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: FutureBuilder<List<FoodModel>>(
        future: Database_getAllFoodModelDelayedSetTimer(2),
        builder: (context, snapshot) {
          if (snapshot.data?.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ยังไม่มีข้อมูล(สำหรับทำรายการ)",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "โปรดเพิ่มเมนูก่อนทำรายการ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Card(
                    color: Colors.black,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 1.5, 5, 1.5),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Client_Restmenu(
                                      foodmenu: db.getAllFoodMenu_Database())),
                              (route) => false),
                          child: Text(
                            "เพิ่ม เมนู",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.data?.length != null) {
            if (snapshot.data!.length > 0) {
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  AspectRatio(
                    aspectRatio: 22 / 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 0,
                          child: AspectRatio(
                            aspectRatio: 5 / 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: active_colors[0],
                                  side: BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      strokeAlign: StrokeAlign.inside)),
                              onPressed: () {
                                setState(() {
                                  menu[0] = true;
                                  menu[1] = false;
                                  menu[2] = false;
                                  menu[3] = false;
                                  print("All Type menu = ${menu}");
                                  if (menu[0] == true) {
                                    active_colors[0] =
                                        Color.fromARGB(255, 114, 255, 59);
                                    active_colors[1] = Colors.white;
                                    active_colors[2] = Colors.white;
                                    active_colors[3] = Colors.white;
                                    print("Condition Success");
                                  }
                                });
                              },
                              child: Text(
                                "ทั้งหมด",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 0,
                          child: AspectRatio(
                            aspectRatio: 5 / 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: active_colors[1],
                                  side: BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      strokeAlign: StrokeAlign.inside)),
                              child: Text(
                                "อาหาร",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 28,
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                setState(() {
                                  menu[0] = false;
                                  menu[1] = true;
                                  menu[2] = false;
                                  menu[3] = false;
                                  print("อาหาร menu = ${menu}");
                                  active_colors[0] = Colors.white;
                                  active_colors[1] =
                                      Color.fromARGB(255, 255, 155, 49);
                                  active_colors[2] = Colors.white;
                                  active_colors[3] = Colors.white;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 0,
                          child: AspectRatio(
                            aspectRatio: 5 / 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: active_colors[2],
                                  side: BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      strokeAlign: StrokeAlign.inside)),
                              onPressed: () {
                                menu[0] = false;
                                menu[1] = false;
                                menu[2] = true;
                                menu[3] = false;

                                print("เครื่องดื่ม menu = ${menu}");
                                if (menu[2] == true) {
                                  active_colors[0] = Colors.white;
                                  active_colors[1] = Colors.white;
                                  active_colors[2] =
                                      Color.fromARGB(255, 95, 239, 255);
                                  active_colors[3] = Colors.white;
                                }
                                setState(() {});
                              },
                              child: Text(
                                "เครื่องดื่ม",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 34,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 0,
                          child: AspectRatio(
                            aspectRatio: 5 / 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: active_colors[3],
                                  side: BorderSide(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      strokeAlign: StrokeAlign.inside)),
                              onPressed: () {
                                menu[0] = false;
                                menu[1] = false;
                                menu[2] = false;
                                menu[3] = true;

                                print("เครื่องดื่ม menu = ${menu}");
                                if (menu[3] == true) {
                                  active_colors[0] = Colors.white;
                                  active_colors[1] = Colors.white;
                                  active_colors[2] = Colors.white;
                                  active_colors[3] =
                                      Color.fromARGB(255, 255, 126, 169);
                                }
                                setState(() {});
                              },
                              child: Text(
                                "ของหวาน",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 34,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          print("In ListView checkbox = ${check}");
                          if (menu[0] == true) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  splashColor: Colors.black26,
                                  child: ListTile(
                                    leading: Checkbox(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.black),
                                        checkColor: Colors.amber,
                                        value: check[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            print(
                                                "#####  ######  ####isEnableButton = ${_isEnableActiveButton}");
                                            if (check[index] != true) {
                                              print("Change Boolean Success");
                                              check_length++;
                                              check[index] = true;
                                              print(
                                                  "check[${index}] = ${check[index]}");
                                            } else {
                                              check[index] = false;
                                              check_length--;
                                            }
                                            for (int i = 0;
                                                i < check.length;
                                                i++) {
                                              if (check[i] == true) {
                                                _isEnableActiveButton = true;
                                                break;
                                              } else if (check[i] == false) {
                                                _isEnableActiveButton = null;
                                              }
                                            }
                                          });
                                        }),
                                    title: Text(
                                      "${snapshot.data?[index].food_name}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "ประเภท : ${snapshot.data?[index].food_type}",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                26,
                                      ),
                                    ),
                                    trailing: Text(
                                      "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              26,
                                          color: Color.fromARGB(255, 0, 213, 7),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  onTap: () async {
                                    String? foodmenu_name = await snapshot
                                        .data?[index].food_name
                                        .toString();
                                    print("${index} =>>> ${check[index]}");
                                    setState(() {
                                      if (check[index] != true) {
                                        check_length++;
                                        check[index] = true;
                                        savingInformation
                                            ?.add(foodmenu_name!.toString());
                                      } else {
                                        check[index] = false;
                                        savingInformation?.removeWhere(
                                            (items) => items == foodmenu_name);
                                        check_length--;
                                      }
                                      print(
                                          "########<><><><>Ontap... ${snapshot.data?[index].food_name} | ${savingInformation}");
                                    });
                                    for (int i = 0; i < check.length; i++) {
                                      if (check[i] == true) {
                                        _isEnableActiveButton = true;
                                        break;
                                      } else if (check[i] == false) {
                                        _isEnableActiveButton = null;
                                      }
                                    }
                                    FoodModel foodmenu = FoodModel(
                                        food_name:
                                            snapshot.data?[index].food_name,
                                        food_type:
                                            snapshot.data?[index].food_type,
                                        food_price:
                                            snapshot.data?[index].food_price);
                                    String my_UID =
                                        await db.get_FoodUID(foodmenu);
                                  },
                                ),
                              ),
                            );
                          } else if (menu[1] == true &&
                              snapshot.data?[index].food_type !=
                                  "เครื่องดื่ม" &&
                              snapshot.data?[index].food_type != "ของหวาน") {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  splashColor: Colors.black26,
                                  child: ListTile(
                                    leading: Checkbox(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.black),
                                        checkColor: Colors.amber,
                                        value: check[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            print(
                                                "#####  ######  ####isEnableButton = ${_isEnableActiveButton}");
                                            if (check[index] != true) {
                                              print("Change Boolean Success");
                                              check_length++;
                                              check[index] = true;
                                              print(
                                                  "check[${index}] = ${check[index]}");
                                            } else {
                                              check[index] = false;
                                              check_length--;
                                            }
                                            for (int i = 0;
                                                i < check.length;
                                                i++) {
                                              if (check[i] == true) {
                                                _isEnableActiveButton = true;
                                                break;
                                              } else if (check[i] == false) {
                                                _isEnableActiveButton = null;
                                              }
                                            }
                                          });
                                        }),
                                    title: Text(
                                      "${snapshot.data?[index].food_name}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "ประเภท : ${snapshot.data?[index].food_type}",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                26,
                                      ),
                                    ),
                                    trailing: Text(
                                      "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              26,
                                          color: Color.fromARGB(255, 0, 213, 7),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  onTap: () async {
                                    String? foodmenu_name = await snapshot
                                        .data?[index].food_name
                                        .toString();
                                    print("${index} =>>> ${check[index]}");
                                    setState(() {
                                      if (check[index] != true) {
                                        check_length++;
                                        check[index] = true;
                                        savingInformation
                                            ?.add(foodmenu_name!.toString());
                                      } else {
                                        check[index] = false;
                                        savingInformation?.removeWhere(
                                            (items) => items == foodmenu_name);
                                        check_length--;
                                      }
                                      print(
                                          "########<><><><>Ontap... ${snapshot.data?[index].food_name} | ${savingInformation}");
                                    });
                                    for (int i = 0; i < check.length; i++) {
                                      if (check[i] == true) {
                                        _isEnableActiveButton = true;
                                        break;
                                      } else if (check[i] == false) {
                                        _isEnableActiveButton = null;
                                      }
                                    }
                                    FoodModel foodmenu = FoodModel(
                                        food_name:
                                            snapshot.data?[index].food_name,
                                        food_type:
                                            snapshot.data?[index].food_type,
                                        food_price:
                                            snapshot.data?[index].food_price);
                                    String my_UID =
                                        await db.get_FoodUID(foodmenu);
                                  },
                                ),
                              ),
                            );
                          } else if (menu[2] == true &&
                              snapshot.data?[index].food_type != "อาหาร" &&
                              snapshot.data?[index].food_type != "ของหวาน") {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  splashColor: Colors.black26,
                                  child: ListTile(
                                    leading: Checkbox(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.black),
                                        checkColor: Colors.amber,
                                        value: check[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            print(
                                                "#####  ######  ####isEnableButton = ${_isEnableActiveButton}");
                                            if (check[index] != true) {
                                              print("Change Boolean Success");
                                              check_length++;
                                              check[index] = true;
                                              print(
                                                  "check[${index}] = ${check[index]}");
                                            } else {
                                              check[index] = false;
                                              check_length--;
                                            }
                                            for (int i = 0;
                                                i < check.length;
                                                i++) {
                                              if (check[i] == true) {
                                                _isEnableActiveButton = true;
                                                break;
                                              } else if (check[i] == false) {
                                                _isEnableActiveButton = null;
                                              }
                                            }
                                          });
                                        }),
                                    title: Text(
                                      "${snapshot.data?[index].food_name}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "ประเภท : ${snapshot.data?[index].food_type}",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                26,
                                      ),
                                    ),
                                    trailing: Text(
                                      "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              26,
                                          color: Color.fromARGB(255, 0, 213, 7),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  onTap: () async {
                                    String? foodmenu_name = await snapshot
                                        .data?[index].food_name
                                        .toString();
                                    print("${index} =>>> ${check[index]}");
                                    setState(() {
                                      if (check[index] != true) {
                                        check_length++;
                                        check[index] = true;
                                        savingInformation
                                            ?.add(foodmenu_name!.toString());
                                      } else {
                                        check[index] = false;
                                        savingInformation?.removeWhere(
                                            (items) => items == foodmenu_name);
                                        check_length--;
                                      }
                                      print(
                                          "########<><><><>Ontap... ${snapshot.data?[index].food_name} | ${savingInformation}");
                                    });
                                    for (int i = 0; i < check.length; i++) {
                                      if (check[i] == true) {
                                        _isEnableActiveButton = true;
                                        break;
                                      } else if (check[i] == false) {
                                        _isEnableActiveButton = null;
                                      }
                                    }
                                    FoodModel foodmenu = FoodModel(
                                        food_name:
                                            snapshot.data?[index].food_name,
                                        food_type:
                                            snapshot.data?[index].food_type,
                                        food_price:
                                            snapshot.data?[index].food_price);
                                    String my_UID =
                                        await db.get_FoodUID(foodmenu);
                                  },
                                ),
                              ),
                            );
                          } else if (menu[2] &&
                              snapshot.data?[index].food_type != "อาหาร" &&
                              snapshot.data?[index].food_type != "ของหวาน") {
                            if (drink_count > 0) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Card(
                                  elevation: 5,
                                  child: InkWell(
                                    splashColor: Colors.black26,
                                    child: ListTile(
                                      leading: Checkbox(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.black),
                                          checkColor: Colors.amber,
                                          value: check[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              print(
                                                  "#####  ######  ####isEnableButton = ${_isEnableActiveButton}");
                                              if (check[index] != true) {
                                                print("Change Boolean Success");
                                                check_length++;
                                                check[index] = true;
                                                print(
                                                    "check[${index}] = ${check[index]}");
                                              } else {
                                                check[index] = false;
                                                check_length--;
                                              }
                                              for (int i = 0;
                                                  i < check.length;
                                                  i++) {
                                                if (check[i] == true) {
                                                  _isEnableActiveButton = true;
                                                  break;
                                                } else if (check[i] == false) {
                                                  _isEnableActiveButton = null;
                                                }
                                              }
                                            });
                                          }),
                                      title: Text(
                                        "${snapshot.data?[index].food_name}",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "ประเภท : ${snapshot.data?[index].food_type}",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              26,
                                        ),
                                      ),
                                      trailing: Text(
                                        "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                26,
                                            color:
                                                Color.fromARGB(255, 0, 213, 7),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    onTap: () async {
                                      String? foodmenu_name = await snapshot
                                          .data?[index].food_name
                                          .toString();
                                      print("${index} =>>> ${check[index]}");
                                      setState(() {
                                        if (check[index] != true) {
                                          check_length++;
                                          check[index] = true;
                                          savingInformation
                                              ?.add(foodmenu_name!.toString());
                                        } else {
                                          check[index] = false;
                                          savingInformation?.removeWhere(
                                              (items) =>
                                                  items == foodmenu_name);
                                          check_length--;
                                        }
                                        print(
                                            "########<><><><>Ontap... ${snapshot.data?[index].food_name} | ${savingInformation}");
                                      });
                                      for (int i = 0; i < check.length; i++) {
                                        if (check[i] == true) {
                                          _isEnableActiveButton = true;
                                          break;
                                        } else if (check[i] == false) {
                                          _isEnableActiveButton = null;
                                        }
                                      }
                                      FoodModel foodmenu = FoodModel(
                                          food_name:
                                              snapshot.data?[index].food_name,
                                          food_type:
                                              snapshot.data?[index].food_type,
                                          food_price:
                                              snapshot.data?[index].food_price);
                                      String my_UID =
                                          await db.get_FoodUID(foodmenu);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text("ไม่มีรายการ"),
                              );
                            }
                          } else if (menu[3] &&
                              snapshot.data?[index].food_type != "อาหาร" &&
                              snapshot.data?[index].food_type !=
                                  "เครื่องดื่ม") {
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Card(
                                elevation: 5,
                                child: InkWell(
                                  splashColor: Colors.black26,
                                  child: ListTile(
                                    leading: Checkbox(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.black),
                                        checkColor: Colors.amber,
                                        value: check[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            print(
                                                "#####  ######  ####isEnableButton = ${_isEnableActiveButton}");
                                            if (check[index] != true) {
                                              print("Change Boolean Success");
                                              check_length++;
                                              check[index] = true;
                                              print(
                                                  "check[${index}] = ${check[index]}");
                                            } else {
                                              check[index] = false;
                                              check_length--;
                                            }
                                            for (int i = 0;
                                                i < check.length;
                                                i++) {
                                              if (check[i] == true) {
                                                _isEnableActiveButton = true;
                                                break;
                                              } else if (check[i] == false) {
                                                _isEnableActiveButton = null;
                                              }
                                            }
                                          });
                                        }),
                                    title: Text(
                                      "${snapshot.data?[index].food_name}",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      "ประเภท : ${snapshot.data?[index].food_type}",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                26,
                                      ),
                                    ),
                                    trailing: Text(
                                      "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              26,
                                          color: Color.fromARGB(255, 0, 213, 7),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  onTap: () async {
                                    String? foodmenu_name = await snapshot
                                        .data?[index].food_name
                                        .toString();
                                    print("${index} =>>> ${check[index]}");
                                    setState(() {
                                      if (check[index] != true) {
                                        check_length++;
                                        check[index] = true;
                                        savingInformation
                                            ?.add(foodmenu_name!.toString());
                                      } else {
                                        check[index] = false;
                                        savingInformation?.removeWhere(
                                            (items) => items == foodmenu_name);
                                        check_length--;
                                      }
                                      print(
                                          "########<><><><>Ontap... ${snapshot.data?[index].food_name} | ${savingInformation}");
                                    });
                                    for (int i = 0; i < check.length; i++) {
                                      if (check[i] == true) {
                                        _isEnableActiveButton = true;
                                        break;
                                      } else if (check[i] == false) {
                                        _isEnableActiveButton = null;
                                      }
                                    }
                                    FoodModel foodmenu = FoodModel(
                                        food_name:
                                            snapshot.data?[index].food_name,
                                        food_type:
                                            snapshot.data?[index].food_type,
                                        food_price:
                                            snapshot.data?[index].food_price);
                                    String my_UID =
                                        await db.get_FoodUID(foodmenu);
                                  },
                                ),
                              ),
                            );
                          }
                          return Container();
                        }),
                  ),
                  Flexible(
                    flex: 0,
                    child: ElevatedButton(
                      onPressed: (_isEnableActiveButton != null)
                          ? () {
                              print("click\n going to maekFoodmenu");
                              print(
                                  "Check Saving Data == ${savingInformation} <==============########");
                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Client_preSendOrder(
                                    savingInformation!,
                                    masterID: widget.masterID,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          onSurface: Colors.black,
                          backgroundColor: Colors.amber),
                      child: Container(
                        width: 200,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.note_alt_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "ทำรายการ [${check_length}]",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }

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
        },
      ),
    );
  }
}
