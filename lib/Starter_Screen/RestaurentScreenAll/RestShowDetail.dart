// ignore_for_file: file_names, unnecessary_import, implementation_imports, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, non_constant_identifier_names, override_on_non_overriding_member, annotate_overrides, sized_box_for_whitespace, await_only_futures, unnecessary_brace_in_string_interps, division_optimization, unused_local_variable, unnecessary_string_interpolations, sort_child_properties_last, missing_required_param

import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/models/information_models.dart';
import 'package:foodapp/services/Database.dart';

import 'main_RestaurantScreen.dart';

class RestShowDetail extends StatefulWidget {
  const RestShowDetail({Key? key}) : super(key: key);

  @override
  State<RestShowDetail> createState() => _RestShowDetailState();
}

class _RestShowDetailState extends State<RestShowDetail> {
  @override
  Database db = Database.instance;
  InformationModel? information;
  List<FoodModel>? foodModel;
  List<FoodListModel>? foodlistModel;
  int set_heightlimit({required int limit}) {
    if (limit >= 100) {
      limit = 100;
    }
    if (limit <= 10) {
      limit = 10;
    }
    return limit;
  }

  int set_hightConvertpercentage({required int percent}) {
    if (percent >= 100) {
      percent = 100;
    } else if (percent >= 90) {
      percent = 120;
    } else if (percent >= 80) {
      percent = 140;
    } else if (percent >= 70) {
      percent = 160;
    } else if (percent >= 60) {
      percent = 180;
    } else if (percent >= 50) {
      percent = 200;
    } else if (percent >= 40) {
      percent = 300;
    } else if (percent >= 30) {
      percent = 400;
    } else if (percent >= 20) {
      percent = 500;
    } else {
      percent = 600;
    }
    return percent;
  }

  int set_heightproblem({required int condition}) {
    if (condition >= 1000000) {
      condition = (condition / 100000).toInt();
    } else if (condition >= 100000) {
      condition = (condition / 10000).toInt();
    } else if (condition >= 10000) {
      condition = (condition / 1000).toInt();
    } else if (h_moneyAll >= 1000) {
      condition = (h_moneyAll / 100).toInt();
    } else if (h_moneyAll >= 100) {
      condition = (condition / 10).toInt();
    } else if (condition >= 10) {
      condition = (condition / 1).toInt();
    } else {
      condition = ((Random().nextInt(10)) * 10);
    }
    return condition;
  }

  TextStyle stylertxt =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600);

  String restaurant_name = "ชื่อร้าน",
      restaurant_phone = "09X4X3XX6X",
      restaurant_streetadress = "ที่อยู่ เลขที่ ห้อง ถนน ตำบล อำเภอ จังหวัด",
      restaurant_comment = "คำอธิบายร้าน",
      restaurant_code = "รหัสไปรษณีย์";
  int food_count = 0, drink_count = 0, dessert_count = 0, foodlist_count = 0;
  int total = 0, average_total = 0, total_max = 0, total_min = 999999;
  int h_food = 100,
      h_drink = 100,
      h_dessert = 100,
      h_foodAll = 100,
      h_moneyAll = 100,
      h_max = 100,
      h_min = 100;
  int average = 100;
  double h_avg = 100;
  Future<void> ConnectionInformation() async {
    information = await db.get_Information();
    foodModel = await db.getAllFoodMenu_Database();
    foodlistModel = await db.get_FoodListAll();
    foodlist_count = await foodlistModel!.length;
    for (int i = 0; i < foodlistModel!.length; i++) {
      if (total_max <= foodlistModel![i].total) {
        total_max = foodlistModel![i].total;
      }
      if (total_min >= foodlistModel![i].total) {
        total_min = foodlistModel![i].total;
      }
      total += foodlistModel![i].total;
    }
    print(
        "total ================================>>>> Total ${total} | Max ${total_max} | Min ${total_min}");
    for (int i = 0; i < foodModel!.length; i++) {
      if (foodModel?[i].food_type == "อาหาร") {
        food_count++;
      } else if (foodModel?[i].food_type == "เครื่องดื่ม") {
        drink_count++;
      } else if (foodModel?[i].food_type == "ของหวาน") {
        dessert_count++;
      }
    }
    h_food = (food_count * 10);
    h_drink = (drink_count * 10);
    h_dessert = (dessert_count * 10);
    h_foodAll = (((food_count + drink_count + dessert_count)) * 10).toInt();
    print("FoodAll ==========================asdsad============> ${h_foodAll}");
    h_food = set_heightlimit(limit: h_food);
    h_drink = set_heightlimit(limit: h_drink);
    h_dessert = set_heightlimit(limit: h_dessert);
    h_foodAll = set_heightlimit(limit: h_foodAll);

    print("${h_food} ${h_drink} ${h_dessert} ${h_foodAll}");
    h_moneyAll = total;
    h_moneyAll = set_heightproblem(condition: h_moneyAll);
    h_max = set_heightproblem(condition: total_max);
    h_min = (total_max / total_min).toInt();
    h_min = set_heightproblem(condition: h_min);
    h_avg = (total / foodlist_count);

    if (h_avg >= 1000000) {
      h_avg = (h_avg / 100000);
    } else if (h_avg >= 100000) {
      h_avg = (h_avg / 10000);
    } else if (h_avg >= 10000) {
      h_avg = (h_avg / 1000);
    } else if (h_avg >= 1000) {
      h_avg = (h_avg / 100);
    } else if (h_avg >= 100) {
      h_avg = (h_avg / 10);
    } else if (h_avg >= 10) {
      h_avg = (h_avg / 1);
    } else {
      h_avg = ((Random().nextInt(10)) * 10);
    }
    h_avg = set_heightlimit(limit: h_avg.toInt()).toDouble();

    print("${h_min} ##############");
    h_min = 100 - h_min;

    print(
        "[Before]----######## =====> Food ${h_food} | Drink ${h_drink} | Dessert ${h_dessert} | FoodAll ${h_foodAll} <Hight|Hight> Money All ${h_moneyAll} | Max ${h_max} | Min${h_min} | Average ${h_avg}");
    print(
        "Count ==================>>> Food $food_count | Drink $drink_count | Dessert $dessert_count");

    h_food = set_hightConvertpercentage(percent: h_food);
    h_drink = set_hightConvertpercentage(percent: h_drink);
    h_dessert = set_hightConvertpercentage(percent: h_dessert);
    h_foodAll = set_hightConvertpercentage(percent: h_foodAll);

    h_avg = set_hightConvertpercentage(percent: h_avg.toInt()).toDouble();
    h_moneyAll = set_hightConvertpercentage(percent: h_moneyAll);
    h_max = set_hightConvertpercentage(percent: h_max);
    h_min = set_hightConvertpercentage(percent: h_min);

    print(
        "[After]----###[Height]##### =====> Food ${h_food} | Drink ${h_drink} | Dessert ${h_dessert} | FoodAll ${h_foodAll} <Hight|Hight> Money All ${h_moneyAll} | Max ${h_max} | Min${h_min} | Average ${h_avg}");
    if (total_min == 999999) {
      total_min = 0;
    }

    average = (total / 3.33).toInt();
    restaurant_name = ((information?.res_name != null)
        ? information?.res_name.toString()
        : "ไม่มี(ชื่อร้าน)")!;
    restaurant_phone = ((information?.res_phoneNumber != null)
        ? information?.res_phoneNumber.toString()
        : "0XX-XXX-XXXX")!;
    restaurant_streetadress = ((information?.res_streetAdress != null)
        ? information?.res_streetAdress.toString()
        : "ไม่มีข้อมูล ที่อยู่ อำเภอ ตำบล จังหวัด...")!;
    restaurant_comment = ((information?.res_comment != null)
        ? information?.res_comment.toString()
        : "คำบรรยาย สถานะ (ยังไม่ได้เพิ่มข้อมูล)")!;
    restaurant_code = ((information?.res_code != null)
        ? information?.res_code.toString()
        : "00000")!;
    setState(() {});
  }

  @override
  void initState() {
    ConnectionInformation();
    super.initState();
  }

  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    print(
        "Infinity Food $food_count | Drink $drink_count | Dessert $dessert_count");
    print("${restaurant_name}");
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                print('Going To MainScreen Restaurant');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Main_ScreenRestaurant()),
                    (route) => false);
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.black,
              Colors.black,
            ])),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 238, 238).withOpacity(0),
          body: ListView(
            children: [
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 2,
                    child: Container(
                      width: 250,
                      height: 200,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 145, 145, 145),
                              ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "${restaurant_name}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Container(
                                child: Text(
                                  "${restaurant_phone}",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              "${restaurant_streetadress} ${restaurant_code}",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 4.5 / 2,
                    child: Container(
                      width: 250,
                      height: 200,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 145, 145, 145),
                              ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "คำอธิบายร้าน",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              "${restaurant_comment}",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 2,
                    child: Container(
                      width: 250,
                      height: 200,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 145, 145, 145),
                              ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "รายละเอียด",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "รายได้ทั้งหมด",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${total}.00",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 72, 217)),
                              ),
                              Text(
                                "THB",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "รายได้สูงสุด ",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${total_max}.00",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 135, 5)),
                              ),
                              Text(
                                "THB",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "รายได้ต่ำสุด   ",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${total_min}.00",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 0, 0)),
                              ),
                              Text(
                                "THB",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "รายได้เฉลี่ย    ",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${average}.00",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 142, 182)),
                              ),
                              Text(
                                "THB",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 2,
                    child: Container(
                      width: 380,
                      height: 150,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              end: Alignment.centerRight,
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 255, 153, 102),
                                Color.fromARGB(255, 206, 0, 0),
                              ])),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.352,
                            height: MediaQuery.of(context).size.width / 1.5,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  colors: [
                                    //Color.fromARGB(255, 255, 181, 131),
                                    Color.fromARGB(255, 115, 31, 0),
                                    Colors.black,
                                  ]),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "รายละเอียด",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(1),
                                          color: Color.fromARGB(255, 255, 7, 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  h_food.toDouble()) *
                                              27,
                                          child: Text(
                                            "${food_count}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    61,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 221, 0, 255),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              h_drink.toDouble() *
                                              27),
                                          child: Text(
                                            "${drink_count}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    51,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 44, 7, 255),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  h_dessert.toDouble()) *
                                              27,
                                          child: Text(
                                            "${dessert_count}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    51,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 7, 193, 255),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  h_foodAll.toDouble()) *
                                              27,
                                          child: Text(
                                            "${food_count + drink_count + dessert_count}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    61,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 7, 255, 185),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  h_moneyAll.toDouble()) *
                                              27,
                                          child: Text(
                                            "${h_moneyAll.toInt()}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    71,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 23, 255, 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  h_avg.toDouble()) *
                                              27,
                                          child: Text(
                                            "${average.toInt()}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    71,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 255, 238, 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  h_max.toDouble()) *
                                              27,
                                          child: Text(
                                            "${h_max.toInt()}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    71,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              100,
                                        ),
                                        Container(
                                          color:
                                              Color.fromARGB(255, 255, 123, 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              h_min.toDouble() *
                                              27),
                                          child: Text(
                                            "${h_min.toInt()}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    71,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AspectRatio(
                            aspectRatio: 2 / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 255, 17, 0),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Food",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 255, 0, 247),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Drink",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 30, 0, 255),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Dess.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 0, 251, 255),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "F. All",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 0, 255, 140),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "M.All",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                    SizedBox(
                                      width: 19.25,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 0, 255, 8),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Avg  ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 234, 255, 0),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Max",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              20,
                                      color: Color.fromARGB(255, 255, 137, 19),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Min  ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), /*,*/
    );
  }
}
