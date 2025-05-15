// ignore_for_file: file_names, unnecessary_import, implementation_imports, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print, unnecessary_new, prefer_const_declarations, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, unused_import, prefer_is_empty, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last, must_be_immutable, use_key_in_widget_constructors, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, annotate_overrides, await_only_futures, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddFoodmenu.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestsendProblem.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/services/Storage.dart';
import 'package:foodapp/services/service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/user_models.dart';

class UploadFile extends StatefulWidget {
  FoodModel foodmenu;
  String referenceID_foodMenu;
  UploadFile({required this.foodmenu, required this.referenceID_foodMenu});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

String picture_url = "";
bool refreshInformationLinkImage = false;
Storage eiei = new Storage();

class _UploadFileState extends State<UploadFile> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      picture_url =
          "${widget.foodmenu.food_name}-${widget.referenceID_foodMenu}-FoodMenu";
      setState(() {});
    });
    super.initState();
    setState(() {});
  }

  Widget build(BuildContext context) {
    String picture_url =
        "${widget.foodmenu.food_name}-${widget.referenceID_foodMenu}-FoodMenu";
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              Service sv = Service.instance;
              final fileName =
                  "${widget.foodmenu.food_name}-${widget.referenceID_foodMenu}-FoodMenu";
              picture_url = fileName;
              print("picture_url = ${picture_url}");
              String thislinkImage =
                  await eiei.downloadURL(folder: "test", imageName: fileName);
              print("Done");
              await db.update_Database(
                  collection_start: "user",
                  collection_end: "foodmenu",
                  user_ID: widget.referenceID_foodMenu,
                  field: "linkImage",
                  value: thislinkImage = (thislinkImage == "") ? "NoLinkImage" : thislinkImage,
                  typeString: true);
              setState(() {});
              Future.delayed(Duration(seconds: 3), () => setState(() {}));
            },
            icon: Icon(Icons.refresh),
            label: Text("refresh"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          ),
        ],
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
                Icons.arrow_back_sharp,
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
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          FutureBuilder(
            future: storage.downloadURL(
                folder: "test", imageName: "${picture_url}"),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.data?.length == 0) {
                return Center(
                  child: Container(
                    child: Icon(
                      Icons.photo_library_sharp,
                      size: MediaQuery.of(context).size.width / 13,
                      color: Colors.grey,
                    ),
                    color: Color.fromARGB(255, 228, 228, 228),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                );
              } else if (snapshot.data?.length != null) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(
                      snapshot.data!,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 5),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    color: Color.fromARGB(255, 228, 228, 228),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          ListTile(
            title: Text(
                "${widget.foodmenu.food_name} | ${widget.foodmenu.food_price}.00THB | ประเภท : ${widget.foodmenu.food_type}"),
            subtitle: Text("${widget.referenceID_foodMenu}"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10,
                0, MediaQuery.of(context).size.width / 10, 0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ["png", "jpg", "jpeg"]);
                if (result != null) {
                  File file = File(result.files.single.path.toString());
                  print("Upload File Complete | ${file}");
                }
                Service sv = Service.instance;
                final path = result?.files.single.path;
                final fileName =
                    "${widget.foodmenu.food_name}-${widget.referenceID_foodMenu}-FoodMenu";
                print("Path ${path} \nFileName ${fileName}");

                eiei
                    .uploadFile(
                        filePath: path.toString(),
                        fileName: fileName.toString())
                    .then((value) async {
                  print("Done");
                  await db.update_Database(
                      collection_start: "user",
                      collection_end: "foodmenu",
                      user_ID: widget.referenceID_foodMenu,
                      field: "image",
                      value: fileName,
                      typeString: true);
                });
                picture_url = fileName;
                print("picture_url = ${picture_url}");
                final thislinkImage =
                    await eiei.downloadURL(folder: "test", imageName: fileName);
                print("Done");
                await db.update_Database(
                    collection_start: "user",
                    collection_end: "foodmenu",
                    user_ID: widget.referenceID_foodMenu,
                    field: "linkImage",
                    value: thislinkImage,
                    typeString: true);
                setState(() {});
                Future.delayed(Duration(seconds: 3), () => setState(() {}));
              },
              icon: Icon(Icons.file_upload_outlined,
                  size: MediaQuery.of(context).size.width / 15),
              label: Text(
                "Upload File",
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
