// ignore_for_file: unnecessary_import, unused_import, implementation_imports, camel_case_types, sort_child_properties_last, prefer_const_constructors, duplicate_ignore, file_names, unused_local_variable, avoid_print, unused_element, dead_code, no_leading_underscores_for_local_identifiers, override_on_non_overriding_member, annotate_overrides, must_call_super, unnecessary_brace_in_string_interps, non_constant_identifier_names, avoid_web_libraries_in_flutter, prefer_is_empty, prefer_const_literals_to_create_immutables, use_build_context_synchronously, missing_required_param, avoid_unnecessary_containers, await_only_futures

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientOrderMenu.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/information_models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/models/user_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';

class Foodmenu_order extends StatefulWidget {
  const Foodmenu_order({super.key});

  @override
  State<Foodmenu_order> createState() => _Foodmenu_orderState();
}

class _Foodmenu_orderState extends State<Foodmenu_order> {
  @override
  String resultText = 'ว่างเปล่า';
  List<String> checkID = [];
  Widget build(BuildContext context) {
    Future<List<InformationModel>> CompileIDForDatabase() async {
      List<String> masterUID = await db.get_allUID();

      checkID = await db.get_allUID();
      List<InformationModel> information = [];
      print(
          "###Class Client_FoodMenu Fucntion CompileIDForDatabase Check Parameter ${masterUID} | length [${masterUID.length}]");
      try {
        print("Try Doing push Information from Database[Information]");
        for (int i = 0; i < masterUID.length; i++) {
          information
              .addAll(await db.get_AllInformation(masterID: masterUID[i]));
        }
      } catch (err) {
        rethrow;
      }
      print(
          "###Class Client_FoodMenu Fuction CompileIDForDatabase Check Data in Information [${information}]");
      return information;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                          MaterialPageRoute(
                              builder: (builder) => Client_Menu()),
                          (route) => false);
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                  ),
                  label: Text('')),
            ),
            title: Text("${firebaseAuth.currentUser?.email} "),
            backgroundColor: Colors.black,
          ),
          body: FutureBuilder<List<InformationModel>>(
              future: CompileIDForDatabase(),
              builder: (context, snapshot) {
                if (snapshot.data?.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "ยังไม่มีข้อมูล",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "(โปรดเพิ่มเมนู ไอค่อนทางขวาล่าง)",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.data?.length != null) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
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
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    size:
                                        MediaQuery.of(context).size.width / 10,
                                    color: Colors.amber,
                                  ),
                                  title: Text(
                                    "ชื่อร้าน : ${snapshot.data?[index].res_name}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25),
                                  ),
                                  subtitle: Text(
                                    "${snapshot.data?[index].res_streetAdress}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25),
                                  ),
                                  trailing: Text(
                                    "${snapshot.data?[index].res_phoneNumber}",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                30),
                                  ),
                                ),
                                onTap: () async {
                                  print(
                                      "###[Ontap][Class Client_FoodOrder] Ontap : uid this restaurant is ==> ${checkID[index]}");
                                  String path = checkID[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Client_OrderMenu(
                                        masterID: path,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
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
              })),
    );
  }
}
