// ignore_for_file: file_names, unnecessary_import, implementation_imports, camel_case_types, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, override_on_non_overriding_member, depend_on_referenced_packages, unused_import, annotate_overrides, sort_child_properties_last, sized_box_for_whitespace, avoid_print, avoid_web_libraries_in_flutter, dead_code, unnecessary_brace_in_string_interps, unnecessary_null_comparison, await_only_futures, unused_local_variable, use_build_context_synchronously, missing_required_param, duplicate_import, prefer_is_empty, unnecessary_string_interpolations, unused_field

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/HomePage.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/Client_waitAllow.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/AllowOrder.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddBank.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddCapital.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddData.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddFoodmenu.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestList.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestShowDetail.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestShowTopsell.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestsendProblem.dart';
import 'package:foodapp/TestCode/Test.dart';
import 'package:foodapp/models/TimesetModel.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/scannerQRCODE.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/uploadFile.dart';
import 'package:foodapp/widgets/MySingnout.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Main_ScreenRestaurant extends StatefulWidget {
  const Main_ScreenRestaurant({Key? key}) : super(key: key);

  @override
  State<Main_ScreenRestaurant> createState() => _Main_ScreenRestaurantState();
}

StarNone(Color colors) {
  return Icon(
    Icons.star_border,
    color: colors,
  );
}

StarHalf(Color colors) {
  return Icon(
    Icons.star_half,
    color: colors,
  );
}

StarFull(Color colors) {
  return Icon(
    Icons.star,
    color: colors,
  );
}

ReviewRestaurantForStar(double starPoint) {
  if (starPoint >= 5.0) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
      ],
    );
  } else if (starPoint >= 4.5) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarHalf(Colors.amber),
      ],
    );
  } else if (starPoint >= 4.0) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 3.5) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarHalf(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 3.0) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 2.5) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarHalf(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 2.0) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarFull(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 1.5) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarHalf(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 1.0) {
    return Row(
      children: [
        StarFull(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else if (starPoint >= 0.5) {
    return Row(
      children: [
        StarHalf(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  } else {
    return Row(
      children: [
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
        StarNone(Colors.amber),
      ],
    );
  }
}

Future<void> main(List<String> args) async {
  await WidgetsFlutterBinding.ensureInitialized();
  runApp(Main_ScreenRestaurant());
  String my_ID = "";
}

class _Main_ScreenRestaurantState extends State<Main_ScreenRestaurant> {
  @override
  String master_ID = "";
  List<FoodModel>? foodModel;
  int food_count = 0, drink_count = 0, dessert_count = 0;
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      foodModel = await db.getAllFoodMenu_Database();
      master_ID = await db.my_uid();
      List<FoodListModel> foodmenu = await db.get_FoodListAll();
      print("MyUID =#=#=#=#=#=#=#=#=#=#=#>>>>>>> ${master_ID} | ${foodModel}");
      for (int i = 0; i < foodModel!.length; i++) {
        if (foodModel?[i].food_type == "อาหาร") {
          food_count++;
        } else if (foodModel?[i].food_type == "เครื่องดื่ม") {
          drink_count++;
        } else if (foodModel?[i].food_type == "ของหวาน") {
          dessert_count++;
        }
        setState(() {});
      }
    });
    Future.delayed(Duration(seconds: 15), () {
      setState(() {});
    });
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  String timeSetOpen = '00.00';
  String timeSetClose = '00.00';
  updateTime(String timeSetOpen, String timeSetClose) {
    setState(() {
      this.timeSetOpen = timeSetOpen;
      this.timeSetClose = timeSetClose;
    });
  }

  final auth = FirebaseAuth.instance;
  Database db = Database.instance;
  double starPoint = 0.7;
  int food_length = 0, drink_length = 0;
  Widget build(BuildContext context) {
    final fontsized = MediaQuery.of(context).size.width;
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
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://img.wongnai.com/p/1920x0/2018/05/24/3a0e2ec4c94d4902adcc4360b4ad719d.jpg',
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 12 / 2,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 2.5),
              width: 200,
              height: 65,
              child: Card(
                elevation: 10,
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 2 / 2,
                        child: AspectRatio(
                          aspectRatio: 10 / 2,
                          child: Icon(
                            Icons.shopify_sharp,
                            color: Colors.orange,
                            size: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          StreamBuilder<TimesetModel>(
                              stream: db.get_TimesetOpenClose(
                                  master_UID: master_ID.toString()),
                              builder: (context, snapshot) {
                                print("SADADDDDD ${master_ID}");
                                return Row(
                                  children: [
                                    Text(
                                      'เปิดรับออเดอร์ (${double.tryParse(snapshot.data?.time_Open ?? '00.00')?.toStringAsFixed(2)} - ${snapshot.data?.time_Close ?? '00.00'})',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                      width: 20,
                                      color: Colors.black,
                                    ),
                                    AspectRatio(
                                      aspectRatio: 3 / 2,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shadowColor:
                                                MaterialStateProperty.all(
                                                    Colors.black),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.black)),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (builder) => ChangesTime(
                                                  (snapshot.data?.time_Open) ??
                                                      "00.00",
                                                  snapshot.data?.time_Close ??
                                                      "00.00",
                                                  updateTime));
                                        },
                                        child: Text(
                                          'Set',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(width: 2.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Prefax_ImgBtn(
                      Colors.black,
                      'assets/image_use/Menu.png',
                      1,
                      word: 'เพิ่มเมนู',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    /*Prefax_ImgBtn(
                      Colors.black,
                      'https://d9hhrg4mnvzow.cloudfront.net/business.wongnai.com/restaurant-management-system/c803b1cd-phonne-wma-4x_106m08z000000000000028.png',
                      2,
                      word: 'ชำระเงิน',
                      width: MediaQuery.of(context).size.width / 5,
                    ),*/
                    Prefax_ImgBtn(
                      Colors.black,
                      'assets/image_use/cheft.png',
                      4,
                      word: 'คิว',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Prefax_ImgBtn(
                      Colors.black,
                      'assets/image_use/checkorder.png',
                      5,
                      word: 'รับออเดอร์',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*Prefax_ImgBtn(
                      Colors.black,
                      'https://d9hhrg4mnvzow.cloudfront.net/business.wongnai.com/restaurant-management-system/c803b1cd-phonne-wma-4x_106m08z000000000000028.png',
                      5,
                      word: 'ทำรายการ',
                      width: MediaQuery.of(context).size.width / 5,
                    ),*/
                    Prefax_ImgBtn(
                      Colors.black,
                      'assets/image_use/detail.png',
                      6,
                      word: 'รายละเอียด',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Prefax_ImgBtn(
                      Colors.black,
                      'assets/image_use/list.png',
                      7,
                      word: 'ประวัติ',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Prefax_ImgBtn(
                      Colors.black,
                      'assets/image_use/problem.png',
                      8,
                      word: 'แจ้งปัญหา',
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 4 / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                    elevation: 10,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              color: Colors.orange,
                              elevation: 10,
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    'สั่งผ่านแอพลิเคชั่น',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: fontsized / 20,
                            ),
                            Column(
                              children: [
                                StreamBuilder<List<NotificationModel>>(
                                  stream: db.get_Notification_versionStream(
                                      master_ID: master_ID),
                                  builder: (context, snapshot) {
                                    String message = "ค้นหาออเดอร์...";
                                    if (snapshot.data?.length != 0 &&
                                        snapshot.data?.length != null &&
                                        snapshot.data?[0].status == "wait") {
                                      message = "พบออเดอร์แล้ว~";
                                      //Start Go to Allow Order
                                      Future.delayed(
                                        Duration(seconds: 2),
                                        () {
                                          setState(() {});
                                          String? userID =
                                              snapshot.data?[0].userID;
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AllowOrder_byRestaurant(
                                                          userID:
                                                              userID.toString(),
                                                        )),
                                                (route) => false);
                                          });
                                          setState(() {});
                                        },
                                      );
                                      //End Go to Allow Order
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: fontsized / 100,
                                          ),
                                          Icon(
                                            Icons.shopify_rounded,
                                            color: Colors.orange,
                                            size: fontsized / 13,
                                          ),
                                          SizedBox(
                                            height: fontsized / 40,
                                          ),
                                          Text(
                                            "${message}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: fontsized / 30,
                                          ),
                                          CircularProgressIndicator(
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            height: fontsized / 30,
                                          ),
                                          Text(
                                            message,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
                AspectRatio(
                  aspectRatio: 2 / 2,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 2,
                        child: Container(
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            color: Colors.white,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        print("Scan QR");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QRscan()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(width: 2)),
                                      icon: Icon(
                                        Icons.qr_code_2_rounded,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        color: Colors.black,
                                      ),
                                      label: Text(
                                        "QR Code",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 4 / 2,
                        child: Container(
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            color: Colors.white,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5)),
                                      Icon(
                                        Icons.restaurant_sharp,
                                        size: 20,
                                        color: Colors.orange,
                                        textDirection: TextDirection.rtl,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                        ],
                                      ),
                                      Text(
                                        '  อาหาร  ${food_count} รายการ',
                                        style: TextStyle(
                                            fontSize: fontsized / 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5)),
                                      Icon(
                                        Icons.water_drop_rounded,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 134, 200, 255),
                                        textDirection: TextDirection.rtl,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                        ],
                                      ),
                                      Text(
                                        '  น้ำดื่ม   ${drink_count} รายการ',
                                        style: TextStyle(
                                            fontSize: fontsized / 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5)),
                                      Icon(
                                        Icons.cookie,
                                        size: 20,
                                        color:
                                            Color.fromARGB(255, 255, 193, 255),
                                        textDirection: TextDirection.rtl,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 5),
                                        ],
                                      ),
                                      Text(
                                        '  ของหวาน   ${dessert_count} รายการ',
                                        style: TextStyle(
                                            fontSize: fontsized / 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 10,
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Flexible(
                    flex: 10,
                    child: ListTile(
                      onTap: () async {
                        String masterID = await db.my_uid();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Client_Restmenu(
                                    foodmenu: db.getAllFoodMenu_Database())));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.add_reaction_sharp,
                        size: 36,
                      ),
                      title: Text(
                        'AddMenu',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCapitalAndShow(),
                            ));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.more_time_rounded,
                        size: 36,
                      ),
                      title: Text(
                        'Queue',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestShowReview()));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.shopping_cart_checkout_rounded,
                        size: 36,
                      ),
                      title: Text(
                        'Order',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestShowDetail()));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.data_exploration_sharp,
                        size: 36,
                      ),
                      title: Text(
                        'Detail',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestList()));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons. /*history_edu*/ event_note_outlined,
                        size: 36,
                      ),
                      title: Text(
                        'History',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestAddPay()));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.attach_money_outlined,
                        size: 36,
                      ),
                      title: Text(
                        'Pay Bank',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestAddData()));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.note_alt_rounded,
                        size: 36,
                      ),
                      title: Text(
                        'About',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestLookingProblem()));
                      },
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      tileColor: Colors.orange,
                      leading: Icon(
                        Icons.report_problem_rounded,
                        size: 36,
                      ),
                      title: Text(
                        'Problem',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  // Flexible(
                  //   flex: 4,
                  //   child: ListTile(
                  //     onTap: () {},
                  //     iconColor: Colors.white,
                  //     textColor: Colors.white,
                  //     tileColor: Colors.amber,
                  //     leading: Icon(
                  //       Icons.account_circle_sharp,
                  //       size: 36,
                  //     ),
                  //     title: Text(
                  //       'Account',
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Flexible(flex: 0, child: MySignOut()),
          ],
        ),
      ),
    );
  }
}

class ChangesTime extends StatefulWidget {
  String timeSetOpen, timeSetClose;
  Function updateTime;
  ChangesTime(this.timeSetOpen, this.timeSetClose, this.updateTime);
  @override
  State<ChangesTime> createState() => _ChangesTimeState();
}

class _ChangesTimeState extends State<ChangesTime> {
  @override
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  Widget build(BuildContext context) {
    if (widget.timeSetOpen != "00.00") {
      controller1.text = widget.timeSetOpen.toString();
    }
    if (widget.timeSetClose != "00.00") {
      controller2.text = widget.timeSetClose.toString();
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(10, 200, 10, 200),
      children: [
        Column(
          children: [
            AlertDialog(
              content: Column(
                children: [
                  TextFormField(
                    controller: controller1,
                    keyboardType: TextInputType.numberWithOptions(),
                    maxLength: 5,
                    decoration: InputDecoration(
                      hintText: 'เวลาเปิด ${widget.timeSetOpen}',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller2,
                    maxLength: 5,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      hintText: 'เวลาปิด ${widget.timeSetClose}',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 51, 255, 0))),
                  onPressed: () async {
                    if (controller1.text == '' || controller1.text == null) {
                      controller1.text = "00.00";
                    }
                    if (controller2.text == '' || controller2.text == null) {
                      controller2.text = "00.00";
                    }
                    TimesetModel timesetModel = TimesetModel(
                        time_Open: controller1.text,
                        time_Close: controller2.text);
                    await db.add_Timeset(timesetModel: timesetModel);
                    Navigator.pop(context, 'Accept');
                    controller1.clear();
                    controller2.clear();
                    setState(() {});
                  },
                  child: Text('ยืนยัน',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 255, 0, 0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 'Cancle');
                  },
                  child: Text('ยกเลิก',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class Prefax_ImgBtn extends StatefulWidget {
  Color colors;
  String link, word;
  int numBerFunction;
  double width, height;
  Prefax_ImgBtn(this.colors, this.link, this.numBerFunction,
      {this.width = 94, this.height = 90, this.word = 'ชื่อปุ่ม?'});

  @override
  State<Prefax_ImgBtn> createState() => _Prefax_ImgBtnState();
}

class _Prefax_ImgBtnState extends State<Prefax_ImgBtn> {
  Database db = Database.instance;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: widget.colors.withOpacity(0.1),
      onTap: () async {
        String uid = "";
        print("[Prefax_ImgBtn] UID =====>>>>>>> ${uid}");
        if (widget.numBerFunction == 1) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Client_Restmenu(foodmenu: db.getAllFoodMenu_Database())));
        } else if (widget.numBerFunction == 2) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RestAddPay()));
        } else if (widget.numBerFunction == 3) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RestAddData()));
        } else if (widget.numBerFunction == 4) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddCapitalAndShow(),
              ));
        } else if (widget.numBerFunction == 5) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RestShowReview()));
        } else if (widget.numBerFunction == 6) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RestShowDetail()));
        } else if (widget.numBerFunction == 7) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RestList()));
        } else if (widget.numBerFunction == 8) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RestLookingProblem()));
        }
      },
      child: Column(
        children: [
          Image.asset(
            widget.link,
            width: widget.width,
            height: widget.height,
          ),
          Text(widget.word),
        ],
      ),
    );
  }
}
