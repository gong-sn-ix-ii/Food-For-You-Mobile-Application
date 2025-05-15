// ignore_for_file: file_names, unused_import, unnecessary_import, implementation_imports, must_be_immutable, camel_case_types, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, unnecessary_string_interpolations, depend_on_referenced_packages, annotate_overrides, override_on_non_overriding_member, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, avoid_print, deprecated_member_use, no_leading_underscores_for_local_identifiers, await_only_futures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientOrderMenu.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/user_models.dart';
import 'package:foodapp/services/camera_scanQR.dart';
import 'package:foodapp/services/service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Scanned_QRCODE extends StatefulWidget {
  String url = "";
  String format = "";
  String socialDistance = "";
  Scanned_QRCODE(
      {required this.url, required this.format, required this.socialDistance});

  @override
  State<Scanned_QRCODE> createState() => _Scanned_QRCODEState();
}

class _Scanned_QRCODEState extends State<Scanned_QRCODE> {
  @override
  // ignore: override_on_non_overriding_member
  bool line = false,
      facebook = false,
      youtube = false,
      twich = false,
      foodapp = false,
      instagram = false;
  Color theme_app = Colors.white;
  Color font_color = Colors.black;
  String url_image =
      "https://cdn.pixabay.com/photo/2019/10/16/09/09/doraemon-4553920_1280.png"
          .toString();
  List<String> master_ID = [];
  void initState() {
    // ignore: todo
    // TODO: implement initState
    if (widget.socialDistance == "line") {
      line = true;
      url_image =
          "https://line.me/static/115d5539e2d10b8da66d31ce22e6bccd/84249/favicon.png";
      theme_app = Color.fromARGB(255, 0, 255, 8);
      font_color = Colors.black;
    } else if (widget.socialDistance == "facebook") {
      facebook = true;
      url_image =
          "https://cdn.pixabay.com/photo/2021/12/10/16/37/facebook-6860914__340.png";
      theme_app = Color.fromARGB(255, 50, 163, 255);
      font_color = Colors.white;
    } else if (widget.socialDistance == "youtube") {
      youtube = true;
      url_image =
          "https://assets.brandinside.asia/uploads/2016/10/YouTube-logo-full_color.png";
      theme_app = Color.fromARGB(255, 253, 17, 0);
      font_color = Colors.white;
    } else if (widget.socialDistance == "twich") {
      twich = true;
      url_image =
          "https://static.twitchcdn.net/assets/mobile_iphone-526a4005c7c0760cb83f.png";
      theme_app = Colors.purple;
      font_color = Colors.black;
    } else if (widget.socialDistance == "instagram") {
      instagram = true;
      url_image =
          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/1200px-Instagram_logo_2022.svg.png";
      theme_app = Color.fromARGB(255, 255, 230, 155);
      font_color = Colors.black;
    } else if (widget.socialDistance == "foodApp") {
      foodapp = true;
      url_image =
          "https://firebasestorage.googleapis.com/v0/b/fir-instance-b5220.appspot.com/o/Logo.png?alt=media&token=df1c6b0e-7b69-430e-8b71-e1d971bb7457";
      theme_app = Colors.amber;
      font_color = Colors.black;
      master_ID = widget.url.split("/user/");
      master_ID.remove("");
    }
    setState(() {});
    super.initState();
    setState(() {});
  }

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
          // ignore: prefer_const_constructors
          title: Center(
            child: Text(
              "${widget.socialDistance}          ",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        // ignore: prefer_const_literals_to_create_immutables
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage("${url_image.toString()}",
                    scale: MediaQuery.of(context).size.width / 60),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Text(
                "${widget.url}",
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 40),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.black, width: 3),
                      backgroundColor: theme_app,
                      elevation: 15),
                  onPressed: () async {
                    if (await canLaunch(widget.url) &&
                        widget.socialDistance != "foodApp") {
                      print("canLaunch");
                      await launch(widget.url);
                    } else if (widget.socialDistance == "foodApp") {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Client_OrderMenu(masterID: master_ID[0])),
                          (route) => false);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width / 50),
                    child: Text(
                      "ติดตามผ่าน ${widget.socialDistance}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          color: font_color,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        ));
  }
}
