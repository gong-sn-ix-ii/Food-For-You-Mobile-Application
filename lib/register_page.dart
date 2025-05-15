// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, unused_import, avoid_print, prefer_final_fields, unrelated_type_equality_checks, dead_code, unnecessary_brace_in_string_interps, body_might_complete_normally_nullable, unused_label, avoid_web_libraries_in_flutter, unused_field, empty_catches, deprecated_member_use, unused_local_variable, await_only_futures, depend_on_referenced_packages, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'AccountUser.dart';
import 'HomePage.dart';
import 'models/user_models.dart';
import 'boxInput.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterAccount extends StatefulWidget {
  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  get fromKey => GlobalKey<FormState>();
  final double radius = 30;
  final formKey = GlobalKey<FormState>();

  Future<FirebaseApp> firebase = Firebase.initializeApp();

  var clearText = '';
  bool isLoading = false, user_mode = true, service_mode = false;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  CollectionReference _accountUser =
      FirebaseFirestore.instance.collection('user');

  IconData iconapp = Icons.email;
  AccountUser profile = AccountUser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('${snapshot.error}')),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Login App',
                theme: ThemeData(primaryColor: Colors.black),
                home: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Scaffold(
                    /*appBar: AppBar(
                      leading: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage())),
                          child: Icon(Icons.arrow_back)),
                      backgroundColor: Colors.black,
                    ),*/
                    backgroundColor: Colors.white.withOpacity(0),
                    body: ListView(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child:
                                         Image.asset(
                                    'assets/image_use/Logo.png',
                                    width:
                                        MediaQuery.of(context).size.width / 1.4,
                                  ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 15, 20, 0),
                                          child: TextFormField(
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'กรุณากรอกอีเมลล์ให้ถูกต้อง'),
                                              EmailValidator(
                                                  errorText:
                                                      'ระบุอีเมลล์ไม่ถูกต้อง'),
                                            ]),
                                            obscureText: false,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.email),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              radius)),
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 255, 160, 35),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )),
                                              border: OutlineInputBorder(),
                                              hintText: 'อีเมลล์',
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 82, 82, 82)),
                                            ),
                                            onSaved: (String? email) {
                                              profile.email = email;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 15, 20, 0),
                                          child: TextFormField(
                                            controller: _password,
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'กรุณากรอกรหัสผ่าน'),
                                              MinLengthValidator(8,
                                                  errorText:
                                                      'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร'),
                                            ]),
                                            onSaved: (String? pass) {
                                              _password.text = pass.toString();
                                              profile.password =
                                                  _password.toString();
                                            },
                                            obscureText: true,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.lock),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              radius)),
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 255, 160, 35),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )),
                                              border: OutlineInputBorder(),
                                              hintText: 'รหัสผ่าน',
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 82, 82, 82)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 15, 20, 0),
                                          child: TextFormField(
                                            controller: _confirmpassword,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return ('กรุณากรอกรหัสผ่าน');
                                              }
                                              if (value.length < 8) {
                                                return ('รหัสผ่านควรมี 8 ตัวอย่างต่ำ');
                                              }
                                              if (_password.text !=
                                                  _confirmpassword.text) {
                                                return ('รหัสผ่านไม่ตรงกัน');
                                              }
                                            },
                                            onSaved: (String? password) {
                                              profile.confpassword = password;
                                            },
                                            obscureText: true,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.lock),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              radius)),
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 255, 160, 35),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )),
                                              border: OutlineInputBorder(),
                                              hintText: 'ยืนยันรหัสผ่าน',
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 82, 82, 82)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.orange,
                                          value: user_mode,
                                          onChanged: (value) {
                                            setState(() {
                                              if (user_mode != true) {
                                                user_mode = true;
                                                service_mode = false;
                                              } else {
                                                user_mode = true;
                                                service_mode = false;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          "ผู้ใช้(User)",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.black,
                                          checkColor: Colors.white,
                                          hoverColor: Colors.black,
                                            value: service_mode,
                                            onChanged: (value) {
                                              setState(() {
                                                if (service_mode != true) {
                                                  user_mode = false;
                                                  service_mode = true;
                                                } else {
                                                  service_mode = true;
                                                  user_mode = false;
                                                }
                                              });
                                            }),
                                        Text(
                                          "ร้านอาหาร(Rf)",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: TextFormField(
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'กรุณากรอก วัน/เดือน/ปีเกิด ให้ถูกต้อง'),
                                              MaxLengthValidator(10,
                                                  errorText:
                                                      'ป้อนวันเกิดได้ไม่เกิน 10 ตัวอักษร'),
                                              DateValidator(('dd/mm/yyyy'),
                                                  errorText:
                                                      'ป้อนวันเกิดไม่ถูกต้องตามหลัก dd/mm/yyyy')
                                              //PatternValidator("/",errorText:"คุณลืมกรอกสัญลักษณ์ '/' คั่นระหว่างข้อมูล")
                                            ]),
                                            obscureText: false,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.date_range_sharp),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              radius)),
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 255, 160, 35),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )),
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  'วัน/เดือน/ปีเกิด (dd/mm/yyyy)',
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 82, 82, 82)),
                                            ),
                                            onSaved: (String? dateTime) {
                                              profile.date = dateTime;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 15, 20, 0),
                                          child: TextFormField(
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง'),
                                              MinLengthValidator(10,
                                                  errorText:
                                                      'เบอร์โทรศัพท์ต้องมีความยาว 10 ตัว'),
                                              MaxLengthValidator(10,
                                                  errorText:
                                                      'เบอร์โทรศัพท์ต้องมีความยาวไม่เกิน 10 ตัว'),
                                              PatternValidator('',
                                                  errorText:
                                                      'อีเมลล์ไม่ถูกต้อง @'),
                                            ]),
                                            obscureText: false,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.phone),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              radius)),
                                                  borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 255, 160, 35),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )),
                                              border: OutlineInputBorder(),
                                              hintText: 'เบอร์โทรศัพท์',
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromARGB(
                                                      255, 82, 82, 82)),
                                            ),
                                            onSaved: (String? phone) {
                                              profile.telPhone = phone;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0)),
                                        SizedBox(
                                          width: 350,
                                          height: 47,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Color.fromARGB(
                                                      255, 255, 136, 0),
                                                ),
                                              ),
                                              child: isLoading
                                                  ? Row(
                                                      /////////////////////////
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SpinKitRing(
                                                          size: 30,
                                                          lineWidth: 5,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          color:
                                                              Colors.lightBlue,
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0)),
                                                        Text(
                                                          'กรุณารอสักครู่...',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      'สมัครบัญชีผู้ใช้งาน',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState?.save();
                                                  setState((() =>
                                                      (isLoading = true)));
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .createUserWithEmailAndPassword(
                                                            email: profile.email
                                                                .toString(),
                                                            password: profile
                                                                .confpassword
                                                                .toString())
                                                        .then((value) async {
                                                      await value.user
                                                          ?.updateProfile(
                                                              displayName:
                                                                  profile.email)
                                                          .then((value2) async {
                                                        String uid =
                                                            value.user!.uid;
                                                        if (user_mode == true) {
                                                          profile.mode = "user";
                                                        } else if (service_mode ==
                                                            true) {
                                                          profile.mode =
                                                              "service";
                                                        } else {
                                                          profile.mode = "user";
                                                        }
                                                        print(
                                                            '#### Update Account Success and | UID = ${uid} ####');
                                                        UserModel model = UserModel(
                                                            email: profile
                                                                .email!
                                                                .toLowerCase()
                                                                .toString(),
                                                            date: profile.date
                                                                .toString(),
                                                            phoneNumber: profile
                                                                .telPhone
                                                                .toString(),
                                                            mode: profile.mode
                                                                .toString());

                                                        Map<String, dynamic>
                                                            data =
                                                            model.toMap();

                                                        await _accountUser
                                                            .doc(uid)
                                                            .set(data)
                                                            .then((value) {
                                                          print(
                                                              '##### Insert data to firestore success ####');
                                                        });
                                                      });
                                                    });
                                                    await Future.delayed(
                                                        Duration(seconds: 2),
                                                        (() {
                                                      setState((() =>
                                                          isLoading = false));
                                                    }));

                                                    Fluttertoast.showToast(
                                                      msg:
                                                          'สมัครบัญชีเสร็จเรียบร้อยครับ!'
                                                              .toString(),
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                    );
                                                    setState(() {
                                                      //reset
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        formKey.currentState
                                                            ?.reset();
                                                        _confirmpassword.text =
                                                            clearText
                                                                .toString();
                                                        _password.text =
                                                            clearText
                                                                .toString();
                                                      }
                                                    });
                                                    if (profile.mode ==
                                                        "user") {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Client_Menu()));
                                                    } else if (profile.mode ==
                                                        "service") {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Main_ScreenRestaurant()));
                                                    }
                                                  } on FirebaseAuthException catch (error) {
                                                    Fluttertoast.showToast(
                                                        msg: error.message
                                                            .toString(),
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                    print(error.code);
                                                    print(error.message);
                                                    setState((() =>
                                                        isLoading = false));
                                                  }
                                                } else {}
                                              }),
                                        ),
                                      ],
                                    ),
                                  ), /////
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return (MaterialApp());
          }
        });
  }
}
