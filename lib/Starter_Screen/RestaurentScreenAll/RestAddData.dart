// ignore_for_file: file_names, unnecessary_import, implementation_imports, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_unnecessary_containers, avoid_print, sort_child_properties_last, use_build_context_synchronously, missing_required_param
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Cooking_Screen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/information_models.dart';
import 'package:foodapp/services/Database.dart';

class RestAddData extends StatefulWidget {
  const RestAddData({Key? key}) : super(key: key);

  @override
  State<RestAddData> createState() => _RestAddDataState();
}

class _RestAddDataState extends State<RestAddData> {
  Database db = Database.instance;
  TextEditingController res_name = TextEditingController();
  TextEditingController res_address = TextEditingController();
  TextEditingController res_code = TextEditingController();
  TextEditingController res_phonNumber = TextEditingController();
  TextEditingController res_comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
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
            if (snapshot.data != null) {
              if (snapshot.data?.res_name != null) {
                res_name.text = snapshot.data!.res_name.toString();
                print("Res name => ${res_name.text}");
              }
              if (snapshot.data?.res_streetAdress != null) {
                res_address.text = snapshot.data!.res_streetAdress.toString();
                print("Res Address => ${res_address.text}");
              }
              res_phonNumber.text = ((snapshot.data?.res_phoneNumber != null)
                  ? snapshot.data?.res_phoneNumber.toString()
                  : "")!;
              res_code.text = ((snapshot.data?.res_code != null)
                  ? snapshot.data?.res_code.toString()
                  : "")!;
              if (snapshot.data?.res_comment != null) {
                res_comment.text = snapshot.data!.res_comment.toString();
              }
              print(
                  "FutureBuilder<Information> Database ==>  ${snapshot.data?.res_name}");
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ชื่อร้าน',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 18),
                          controller: res_name,
                          maxLines: 1,
                          maxLength: 16,
                          decoration: InputDecoration(
                              hintText: 'ชื่อร้าน',
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orange, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2))),
                        ),
                        Text(
                          'ที่อยู่',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            scrollPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            controller: res_address,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            maxLength: 99,
                            decoration: InputDecoration(
                                hintText: 'ที่อยู่ เลขที่ ตำบล อำเภอ',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2))),
                          ),
                        ),
                        Text(
                          'เบอร์โทรศัพท์',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 120, 0),
                          child: TextFormField(
                            scrollPadding: EdgeInsets.all(5),
                            controller: res_phonNumber,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            maxLength: 10,
                            decoration: InputDecoration(
                                hintText: "เบอร์โทรศัพท์(ร้าน)",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2))),
                          ),
                        ),
                        Text(
                          'รหัสไปรษณีย์',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 120, 0),
                          child: TextFormField(
                            scrollPadding: EdgeInsets.all(5),
                            controller: res_code,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'รหัสไปรษณีย์',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2))),
                          ),
                        ),
                        Text(
                          'คำอธิบาย',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          scrollPadding: EdgeInsets.all(5),
                          controller: res_comment,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          maxLength: 290,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            hintText: 'คำอธิบายร้าน',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Button In Future
                  Container(
                    margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      icon: Icon(
                        Icons.save,
                      ),
                      label: Text('Save Data'),
                      onPressed: () async {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => Comeback_Screen());
                        print("Saving...");
                        InformationModel newInformation = InformationModel(
                            res_name: res_name.text.toString(),
                            res_streetAdress: res_address.text.toString(),
                            res_phoneNumber: res_phonNumber.text
                                .toString(), //int.tryParse(res_phonNumber.text),
                            res_code: res_code.text
                                .toString(), //int.tryParse(res_code.text),
                            res_comment: res_comment.text.toString());
                        await db.add_Information(newInformation);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              );
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
          }),
    );
  }
}
