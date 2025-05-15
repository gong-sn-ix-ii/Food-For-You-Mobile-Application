// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors, file_names, avoid_unnecessary_containers, avoid_print, annotate_overrides, non_constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last, missing_required_param, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/information_models.dart';
import 'package:foodapp/models/problemModel.dart';
import 'package:foodapp/services/Database.dart';

class RestLookingProblem extends StatefulWidget {
  const RestLookingProblem({Key? key}) : super(key: key);

  @override
  State<RestLookingProblem> createState() => _RestLookingProblemState();
}

final auth = FirebaseAuth.instance;

class _RestLookingProblemState extends State<RestLookingProblem> {
  Database db = Database.instance;
  TextEditingController res_name = TextEditingController();
  TextEditingController time_now = TextEditingController();
  TextEditingController comment = TextEditingController();
  String date = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  String time = DateTime.now().hour.toString() +
      ":" +
      DateTime.now().minute.toString() +
      ":00";
  TextEditingController date_now = TextEditingController();
  @override
  // ignore: override_on_non_overriding_member
  bool pro1 = true, pro2 = false, pro3 = false, pro4 = false;
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
      body: FutureBuilder<InformationModel>(
          future: db.get_Information(),
          builder: (context, snapshot) {
            if (snapshot.data?.res_name != null) {
              res_name.text = snapshot.data!.res_name.toString();
              print("Res name => ${res_name.text}");
            }
            date_now.text = date.toString();
            time_now.text = time.toString();
            return ListView(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 50, 0),
                    child: Text(
                      'ชื่อร้าน',
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
                  child: TextFormField(
                      maxLength: 39,
                      controller: res_name,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'ชื่อร้าน',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                      )),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 50, 0),
                    child: Text(
                      'วันที่พบปัญหา',
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(7.5, 5, 250, 0),
                  child: TextFormField(
                      controller: date_now,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'วว/ดด/ปปปป',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 50, 0),
                    child: Text(
                      'เวลาที่พบปัญหา',
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(7.5, 5, 250, 0),
                  child: TextFormField(
                      controller: time_now,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: '00.00 > 23.59',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                      )),
                ),
                Row(children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: pro1,
                      onChanged: (value) {
                        setState(() {
                          pro1 = true;
                          pro2 = false;
                          pro3 = false;
                          pro4 = false;
                        });
                      }),
                  Text(
                    'ไม่สามารถเปลี่ยนแปลงข้อมูลได้ ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ]),
                Row(children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: pro2,
                      onChanged: (value) {
                        setState(() {
                          pro1 = false;
                          pro2 = true;
                          pro3 = false;
                          pro4 = false;
                        });
                      }),
                  Text(
                    'ลบและเพิ่มข้อมูลไม่ได้ ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ]),
                Row(children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: pro3,
                      onChanged: (value) {
                        setState(() {
                          pro1 = false;
                          pro2 = false;
                          pro3 = true;
                          pro4 = false;
                        });
                      }),
                  Text(
                    'ข้อมูลไม่ตรงตามที่ใช้งาน',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ]),
                Row(children: [
                  Checkbox(
                      activeColor: Colors.black,
                      value: pro4,
                      onChanged: (value) {
                        setState(() {
                          pro1 = false;
                          pro2 = false;
                          pro3 = false;
                          pro4 = true;
                        });
                      }),
                  Text(
                    'อื่นๆ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ]),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 50, 0),
                    child: Text(
                      'คำอธิบายปัญหา',
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(7.5, 5, 7.5, 0),
                  child: TextFormField(
                      controller: comment,
                      maxLength: 500,
                      maxLines: 5,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'คำอธิบายสำหรับปัญหาที่พบ',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber, width: 2)),
                      )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amber)),
                    onPressed: () async {
                      String name_pb = res_name.text;
                      String date_pb = date_now.text;
                      String time_pb = time_now.text;
                      String title_pb = "";
                      if (pro1 == true) {
                        title_pb = "ไม่สามารถเปลี่ยนแปลงข้อมูลได้";
                      } else if (pro2 == true) {
                        title_pb = "ลบและเพิ่มข้อมูลไม่ได้";
                      } else if (pro3 == true) {
                        title_pb = "ข้อมูลที่ได้ไม่ตรงกัน";
                      } else if (pro4 == true) {
                        title_pb = "อื่นๆ";
                      } else {
                        title_pb = "อื่นๆ";
                      }
                      String comment_pb = comment.text;
                      ProblemModel newProblem = ProblemModel(
                          name_pb: name_pb,
                          date_pb: date_pb,
                          time_pb: time_pb,
                          title_pb: title_pb,
                          comment_pb: comment_pb);
                      await db.add_problem(newProblem);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Main_ScreenRestaurant()),
                          (route) => false);
                    },
                    icon: Icon(Icons.message),
                    label: Text('Send'),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
