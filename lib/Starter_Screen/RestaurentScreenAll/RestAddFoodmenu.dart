// ignore_for_file: file_names ignore_for_file: file_names, unnecessary_import, prefer_const_constructors, unused_import, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, non_constant_identifier_names, depend_on_referenced_packages, camel_case_types, file_names, sort_child_properties_last, avoid_print, unnecessary_brace_in_string_interps, unused_field, prefer_final_fields, body_might_complete_normally_nullable, curly_braces_in_flow_control_structures, unnecessary_null_comparison, unrelated_type_equality_checks, unused_element, must_be_immutable, use_key_in_widget_constructors, void_checks, dead_code, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, await_only_futures, override_on_non_overriding_member, annotate_overrides, sized_box_for_whitespace, avoid_web_libraries_in_flutter, prefer_is_empty, no_leading_underscores_for_local_identifiers, unused_local_variable, use_build_context_synchronously, missing_required_param

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/customer_models.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:foodapp/services/service.dart';
import 'package:foodapp/services/uploadFile.dart';
import 'package:url_launcher/url_launcher.dart';

class Client_Restmenu extends StatefulWidget {
  final Future<List<FoodModel>>? foodmenu;
  Client_Restmenu({required this.foodmenu});

  @override
  State<Client_Restmenu> createState() => _Client_RestmenuState();
}

class _Client_RestmenuState extends State<Client_Restmenu> {
  final xy = 5.00;
  final auth = FirebaseAuth.instance;
  Database db = Database.instance;
  List<String> food_name = [];
  List<String> food_price = [];
  List<String> food_address = [];
  List<String> food_type = [];

  @override
  Widget build(BuildContext context) {
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
      //<-----[Start Code]----->\\
      body: FutureBuilder<List<FoodModel>>(
        future: db.getAllFoodMenu_Database(),
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
                  if (snapshot.data?[index].food_type == "อาหาร") {
                    set_icon = Icons.food_bank_sharp;
                    set_color = Colors.amber;
                  } else if (snapshot.data?[index].food_type == "เครื่องดื่ม") {
                    set_icon = Icons.emoji_food_beverage_rounded;
                    set_color = Color.fromARGB(255, 121, 195, 255);
                  } else if (snapshot.data?[index].food_type == "ของหวาน") {
                    set_icon = Icons.bakery_dining;
                    set_color = Color.fromARGB(255, 255, 176, 202);
                  } else {
                    set_icon = Icons.food_bank_sharp;
                    set_color = Colors.amber;
                  }
                  // if (snapshot.data?[index].food_image == "NoImage" ||
                  //     snapshot.data?[index].food_image == null ||
                  //     snapshot.data?[index].food_image == "null") {
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                        flex: 20,
                        onPressed: (context) async {
                          FoodModel delfoodmenu = FoodModel(
                              food_name: snapshot.data?[index].food_name,
                              food_type: snapshot.data?[index].food_type,
                              food_price: snapshot.data?[index].food_price);
                          String myUID = await db.get_FoodUID(delfoodmenu);
                          print(
                              "Deletting Foodmenu name:${snapshot.data?[index].food_name} | uid: ${myUID}");
                          await db.DeleteFoodMenu(delfoodmenu, myUID);
                          Deleted_FoodMenu();
                        },
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
                            leading: (snapshot.data?[index].food_linkImage !=
                                        "NoLinkImage" &&
                                    snapshot.data?[index].food_linkImage !=
                                        null)
                                ? Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                        "${snapshot.data?[index].food_linkImage}"))
                                : Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.image,
                                      color: Color.fromARGB(255, 179, 179, 179),
                                    ),
                                    color: Color.fromARGB(255, 218, 218, 218),
                                  ),
                            title: Text(
                              "ชื่อเมนู : ${snapshot.data?[index].food_name}",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "ประเภท : ${snapshot.data?[index].food_type}",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  color: set_color),
                            ),
                            trailing: Text(
                              "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 30,
                                  color: Color.fromARGB(255, 0, 218, 7)),
                            ),
                          ),
                          onTap: () async {
                            FoodModel foodmenu = FoodModel(
                                food_name: snapshot.data?[index].food_name,
                                food_type: snapshot.data?[index].food_type,
                                food_price: snapshot.data?[index].food_price);
                            String doucumentID_Folder_foodMenu =
                                await db.get_FoodUID(foodmenu);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadFile(
                                          foodmenu: foodmenu,
                                          referenceID_foodMenu:
                                              doucumentID_Folder_foodMenu,
                                        )));
                          },
                        ),
                      ),
                    ),
                  );
                  //}
                  // else if(snapshot.data?[index].food_image != "NoImage"){
                  //   return Slidable(
                  //     endActionPane:
                  //         ActionPane(motion: ScrollMotion(), children: [
                  //       SlidableAction(
                  //         borderRadius: BorderRadius.all(Radius.circular(0)),
                  //         flex: 20,
                  //         onPressed: (context) async {
                  //           FoodModel delfoodmenu = FoodModel(
                  //               food_name: snapshot.data?[index].food_name,
                  //               food_type: snapshot.data?[index].food_type,
                  //               food_price: snapshot.data?[index].food_price);
                  //           String myUID = await db.get_FoodUID(delfoodmenu);
                  //           print(
                  //               "Deletting Foodmenu name:${snapshot.data?[index].food_name} | uid: ${myUID}");
                  //           await db.DeleteFoodMenu(delfoodmenu, myUID);
                  //           Deleted_FoodMenu();
                  //         },
                  //         backgroundColor: Color(0xFFFE4A49),
                  //         foregroundColor: Colors.white,
                  //         icon: Icons.delete,
                  //         label: 'Delete',
                  //       ),
                  //     ]),
                  //     child: Container(
                  //       padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  //       child: Card(
                  //         elevation: 5,
                  //         child: InkWell(
                  //           splashColor: Colors.black26,
                  //           child: ListTile(
                  //             leading: FutureBuilder<String>(
                  //               future: storages.downloadURL(
                  //                   folder: "test",
                  //                   imageName:
                  //                       "${snapshot.data?[index].food_image}"),
                  //               builder: (context, snapshot2) => Container(
                  //                   width: 50,
                  //                   height: 50,
                  //                   child: Image.network(snapshot2.data!)),
                  //             ),
                  //             title: Text(
                  //               "ชื่อเมนู : ${snapshot.data?[index].food_name}",
                  //               style: TextStyle(
                  //                   fontSize:
                  //                       MediaQuery.of(context).size.width / 25, fontWeight: FontWeight.bold),
                  //             ),
                  //             subtitle: Text(
                  //               "ประเภท : ${snapshot.data?[index].food_type}",
                  //               style: TextStyle(
                  //                   fontSize:
                  //                       MediaQuery.of(context).size.width / 25, color: set_color),
                  //             ),
                  //             trailing: Text(
                  //               "ราคา : ${snapshot.data?[index].food_price}.00 THB",
                  //               style: TextStyle(
                  //                   fontSize:
                  //                       MediaQuery.of(context).size.width / 30, color: Color.fromARGB(255, 0, 218, 7)),
                  //             ),
                  //           ),
                  //           onTap: () async {
                  //             FoodModel foodmenu = FoodModel(
                  //                 food_name: snapshot.data?[index].food_name,
                  //                 food_type: snapshot.data?[index].food_type,
                  //                 food_price: snapshot.data?[index].food_price);
                  //             String doucumentID_Folder_foodMenu =
                  //                 await db.get_FoodUID(foodmenu);
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => UploadFile(
                  //                           foodmenu: foodmenu,
                  //                           referenceID_foodMenu:
                  //                               doucumentID_Folder_foodMenu,
                  //                         )));
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }
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
      //<-----[End Code]----->\\
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              Service service = Service.instance;
              String uid = service.get_UID(index: 16);
              print(uid);
              return InputFeedingData(
                uid: uid,
              );
            }),
        child: Icon(
          Icons.add,
          color: Colors.amber,
          size: 40,
        ),
      ),
    );
  }

  Deleted_FoodMenu() {
    setState(() {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return Client_Restmenu(foodmenu: db.getAllFoodMenu_Database());
      }), (route) => false);
    });
  }
}

class InputFeedingData extends StatefulWidget {
  String? uid;
  InputFeedingData({required this.uid});
  @override
  State<InputFeedingData> createState() => _InputFeedingDataState();
}

class _InputFeedingDataState extends State<InputFeedingData> {
  TextEditingController _FoodMenu = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  Database db = Database.instance;
  GlobalKey<FormState> _formkey = GlobalKey();
  int price = 0;
  bool checkFood = true;
  bool checkDrink = false;
  bool checkDesserts = false;
  Service get = Service.instance;
  String? saveType;

  void Random_UID() {
    setState(() {
      widget.uid = get.get_UID(index: 20);
      print(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 100),
      children: [
        AlertDialog(
          key: _formkey,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _FoodMenu,
                validator: (String? menuName) {
                  if (menuName!.isEmpty) {
                    return ('โปรดระบุ ชื่อ');
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.restaurant_menu),
                    focusColor: Colors.amber,
                    hintText: 'ชื่อเมนู',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _price,
                validator: (_price) {
                  if (_price!.isNotEmpty) {
                    return ('โปรดระบุ ราคา');
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money_sharp,
                    ),
                    prefixIconColor: Colors.black,
                    hintText: 'ราคา',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.orange, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Colors.black, style: BorderStyle.solid)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black))),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 20, 0),
                child: Text(
                  'ประเภทเมนู (เลือก 1 ประเภท)',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Colors.orange,
                      value: checkFood,
                      onChanged: (bool? value) {
                        setState(() {
                          checkFood = true;
                          checkDrink = false;
                          checkDesserts = false;
                        });
                      }),
                  InkWell(
                    splashColor: Colors.orange[50],
                    child: Text('อาหาร'),
                    onTap: () {
                      setState(() {
                        checkFood = true;
                        checkDrink = false;
                        checkDesserts = false;
                      });
                    },
                  ),
                  Checkbox(
                      value: checkDrink,
                      activeColor: Colors.blue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkFood = false;
                          checkDrink = true;
                          checkDesserts = false;
                        });
                      }),
                  InkWell(
                    child: Text('เครื่องดื่ม'),
                    splashColor: Colors.blue[50],
                    onTap: () {
                      setState(() {
                        checkFood = false;
                        checkDrink = true;
                        checkDesserts = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 0,
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Color.fromARGB(255, 255, 80, 138),
                      value: checkDesserts,
                      onChanged: (bool? value) {
                        setState(() {
                          checkFood = false;
                          checkDrink = false;
                          checkDesserts = true;
                        });
                      }),
                  InkWell(
                    splashColor: Colors.pink[100],
                    child: Text('ขนมหวาน'),
                    onTap: () {
                      setState(() {
                        checkFood = false;
                        checkDrink = false;
                        checkDesserts = true;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(20),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 255, 34)),
                        fixedSize: MaterialStateProperty.all(Size(90, 30))),
                    onPressed: () {
                      setState(() {
                        if (_FoodMenu.text == null || _FoodMenu.text == '') {
                          _FoodMenu.text = '(ไม่ระบุ)';
                        }

                        if (_price.text == null || _price == '') {
                          _price.text = 0.toString();
                        }
                        String x;
                        price = int.parse(_price.text);

                        if (_controller3.text == Null ||
                            _controller3.text == '') {
                          _controller3.text = 'ที่อยู่';
                        } else {
                          print('All Success');
                        }
                        if (checkFood != false) {
                          saveType = 'อาหาร';
                        } else if (checkDrink != false) {
                          saveType = 'เครื่องดื่ม';
                        } else if (checkDesserts != false) {
                          saveType = 'ของหวาน';
                        } else {
                          saveType = 'ไม่ระบุ';
                        }
                        FoodModel newFoodMenu = FoodModel(
                            food_name: _FoodMenu.text.toString(),
                            food_image: "NoImage",
                            food_linkImage: "NoLinkImage",
                            food_type: saveType,
                            food_price: price);
                        print(
                            "New! Foodmenu => ${newFoodMenu} | UID : ${widget.uid}");
                        String myUID = widget.uid.toString();
                        db.AddFoodMenu(newFoodMenu, myUID);
                        Navigator.pop(
                          context,
                        );
                        print('####1. ${newFoodMenu.food_name} #### |');
                        print('####2. ${newFoodMenu.food_type} #### |');
                        print('####3. ${newFoodMenu.food_price} #### |');
                      });

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Client_Restmenu(
                                  foodmenu: db.getAllFoodMenu_Database())),
                          (route) => false);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancle');
                    },
                    child: Text(
                      'Cancle',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(15),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 245, 0, 0)),
                        fixedSize: MaterialStateProperty.all(Size(90, 30))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
