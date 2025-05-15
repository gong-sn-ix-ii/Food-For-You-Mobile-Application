// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, file_names, unused_import, unused_field, prefer_final_fields, non_constant_identifier_names, avoid_web_libraries_in_flutter, sized_box_for_whitespace, avoid_print, unused_element, prefer_void_to_null, unused_local_variable, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, await_only_futures, unnecessary_null_comparison, depend_on_referenced_packages, sort_child_properties_last, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestAddFoodmenu.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/user_models.dart';
import 'package:foodapp/services/service.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'AccountUser.dart';
import 'Starter_Screen/ClientScreenAll/ClientScreen.dart';
import 'HomePage.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  get fromKey => GlobalKey<FormState>();
  final double radius = 5;
  final Color textbackground = Color.fromARGB(59, 0, 0, 0);
  final formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  var clearText = '';
  bool isLoading = false;

  String? username, passsword, name, email, phoneNumber, dateTime, uid;

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  IconData iconapp = Icons.email;
  AccountUser loginProfile = AccountUser();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
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
                title: 'Restaurent',
                theme: ThemeData(
                  primaryColorDark: Colors.green,
                ),
                home: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.white,
                        Colors.white,
                      ])),
                  child: Scaffold(
                      backgroundColor: Colors.white.withOpacity(0.0),
                      body: ListView(
                        children: [
                          Container(
                            child: SizedBox(
                              height: 80,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //children: [Image.asset('assets/images/orb.png')],
                              //children: [Image.asset('assets/images/TaaumAall1.png')],
                              //children: [Image.asset('assets/images/logo.png')],
                              children: [
                                Image.asset('assets/image_use/Logo.png' ,
                                  width: MediaQuery.of(context).size.width / 1.4,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          /*Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'EZ Food',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ),*/
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            margin: EdgeInsets.fromLTRB(
                                                35, 0, 35, 0),
                                            child: TextFormField(
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText:
                                                        'กรุณากรอกอีเมลล์'),
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
                                                prefixIcon:
                                                    Icon(Icons.account_circle),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    radius)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    134,
                                                                    41),
                                                            width: 2)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    radius)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            width: 2)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                radius)),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 255, 0, 0),
                                                        width: 2)),
                                                border: OutlineInputBorder(),
                                                hintText: 'ชื่อผู้ใช้งาน',
                                                hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 134, 134, 134)),
                                              ),
                                              onSaved: (String? email) {
                                                loginProfile.email =
                                                    email.toString();
                                              }, /////////////////////////////////////// onsave
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                35, 0, 35, 0),
                                            color: Colors.white,
                                            child: TextFormField(
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText:
                                                        'กรุณากรอกรหัสผ่าน'),
                                                MinLengthValidator(8,
                                                    errorText:
                                                        'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร'),
                                              ]),
                                              onSaved: (String? pass) {
                                                loginProfile.password =
                                                    pass.toString();
                                              }, ////////////////////////// onsave
                                              obscureText: true,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    Icon(Icons.lock_open_sharp),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    radius)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    119,
                                                                    255),
                                                            width: 2)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    radius)),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            width: 2)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                radius)),
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 255, 0, 0),
                                                        width: 2)),
                                                border: OutlineInputBorder(),
                                                hintText: 'รหัสผ่าน',
                                                hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 124, 124, 124)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.21,
                                            child: SizedBox(
                                                child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color.fromARGB(
                                                            255, 255, 149, 0)),
                                              ),
                                              child: isLoading
                                                  ? Row(
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
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    0, 0)),
                                                        Text(
                                                          'กรุณารอสักครู่...',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      'เข้าสู่ระบบ',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState?.save();
                                                  if (isLoading != true) {
                                                    setState((() =>
                                                        isLoading = true));
                                                  }
                                                  try {
                                                    await FirebaseAuth.instance
                                                        .signInWithEmailAndPassword(
                                                      email: loginProfile.email
                                                          .toString(),
                                                      password: loginProfile
                                                          .password
                                                          .toString(),
                                                    );
                                                    await Future.delayed(
                                                        Duration(seconds: 2),
                                                        (() {
                                                      formKey.currentState
                                                          ?.reset();
                                                      setState(() =>
                                                          isLoading = false);
                                                    })).then((value) async {
                                                      UserModel userModel =
                                                          await db.Searching_User(
                                                              collection:
                                                                  "user",
                                                              field: "email",
                                                              equalTo: loginProfile
                                                                  .email
                                                                  .toString());
                                                      print(
                                                          "LoginPage Try Login Check mode UserModel ==> ${userModel.mode}");

                                                      if (userModel.mode ==
                                                          "user") {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Client_Menu(),
                                                            ));
                                                      } else if (userModel
                                                              .mode ==
                                                          "service") {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Main_ScreenRestaurant(),
                                                            ));
                                                      } else {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  RegisterAccount(),
                                                            ));
                                                      }
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'เข้าสู่ระบบเรียบร้อยแล้วครับ!'
                                                                  .toString(),
                                                          gravity: ToastGravity
                                                              .CENTER);
                                                      //////////////////////////////////////////////// <Go> Screen
                                                    });
                                                  } on FirebaseAuthException catch (error) {
                                                    String? savedText =
                                                        error.toString();
                                                    if (error.message ==
                                                        'There is no user record corresponding to this identifier. The user may have been deleted.') {
                                                      savedText =
                                                          'ชื่อผู้ใช้งานของคุณไม่มีอยู่ในระบบ!';
                                                    } else if (error.message ==
                                                        'The password is invalid or the user does not have a password.') {
                                                      savedText =
                                                          'ชื่อผู้ใช้งานหรือรหัสผ่านของคุณไม่ถูกต้อง กรุณาตรวจสอบใหม่อีกครั้งครับ!';
                                                    } else if (error.message ==
                                                        'We have blocked all requests from this device due to unusual activity. Try again later.') {
                                                      savedText =
                                                          'มีการพยายามเข้าถึงบัญชีมากเกินไป ผมขอระงับการเข้าถึงบัญชีเป็นเวลา 1 นาทีครับ! ';
                                                    }
                                                    await Future.delayed(
                                                        Duration(seconds: 0),
                                                        () {
                                                      setState(() =>
                                                          isLoading = false);
                                                    });
                                                    Fluttertoast.showToast(
                                                        msg: savedText,
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                    print(error.message
                                                        .toString());
                                                  }
                                                }
                                              }, ////////////////////////// Onpressed
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],

                                  ///End
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          /*Container(
                            width: 320,
                            height: 45,
                            margin: EdgeInsets.fromLTRB(35, 35, 35, 5),
                            child: SignInButton(
                              Buttons.Google,
                              elevation: 5,
                              text: 'เข้าสู่ระบบด้วย Google',
                              onPressed: () =>
                                  processSignInWithGoogle(), ////////////Login Google
                            ),
                          ),
                          Container(
                            width: 320,
                            height: 45,
                            margin: EdgeInsets.fromLTRB(35, 5, 35, 10),
                            child: SignInButton(
                              Buttons.FacebookNew,
                              text: 'เข้าสู่ระบบด้วย Facebook',
                              onPressed: () {}, ////////////Login Facebook
                            ),
                          ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "คุณยังไม่มีบัญชีผู้ใช้ใช่ไหม?",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              // ignore: deprecated_member_use
                              ElevatedButton(
                                child: Text('สมัครบัญชี',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  side: BorderSide(width: 2),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterAccount()));
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              );
            } else {
              return Material();
            }
          }),
    );
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<Null> processSignInWithGoogle() async {
    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((value) async {
        name = value!.displayName;
        email = value.email;

        await value.authentication.then((value2) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: value2.idToken,
            accessToken: value2.accessToken,
          );
          await FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((value3) async {
            uid = value3.user!.uid;
            print(
                'Login With Google Success value with email = ${email} | ID = ${uid} | name = ${name}');
            await FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .snapshots()
                .listen((event) {
              print('Event ===> ${event.data()}');
              if (event.data() == null) {
                print(
                    '####=========>>   email = ${email} | ID = ${uid} | name = ${name}');
                if (event.data == null) {
                  callAddDataDialog().then((value) {
                    if (event.data != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Client_Menu(),
                          ),
                          (route) => false);
                    } else {
                      callAddDataDialog();
                    }
                  });
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Client_Menu(),
                      ),
                      (route) => false);
                }
              } else {}
            });
          });
        });
      }) /*.then((value) async {
        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Client_Menu()));
      })*/
          ;
    });
  }

  Future<Null> callAddDataDialog() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: ListTile(
                title: Text('Input Type ?'),
                subtitle: Text('Please Input Data User'),
              ),
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                    'กรุณากรอก วัน/เดือน/ปีเกิด ให้ถูกต้อง'),
                            MaxLengthValidator(10,
                                errorText: 'ป้อนวันเกิดได้ไม่เกิน 10 ตัวอักษร'),
                            DateValidator(('dd/mm/yyyy'),
                                errorText:
                                    'ป้อนวันเกิดไม่ถูกต้องตามหลัก dd/mm/yyyy')
                            //PatternValidator("/",errorText:"คุณลืมกรอกสัญลักษณ์ '/' คั่นระหว่างข้อมูล")
                          ]),
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range_sharp),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.blue)),
                            border: OutlineInputBorder(),
                            hintText: 'เบอร์โทรศัพท์',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง'),
                            MinLengthValidator(10,
                                errorText: 'เบอร์โทรศัพท์ต้องมีความยาว 10 ตัว'),
                            MaxLengthValidator(10,
                                errorText:
                                    'เบอร์โทรศัพท์ต้องมีความยาวไม่เกิน 10 ตัว'),
                            PatternValidator('',
                                errorText: 'อีเมลล์ไม่ถูกต้อง @'),
                          ]),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.blue)),
                            border: OutlineInputBorder(),
                            hintText: 'เบอร์โทรศัพท์',
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                          onSaved: (velyue) {},
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Client_Menu(),
                          ),
                          (route) => false);
                    },
                    child: Text('OK')),
              ],
            ));
  }

  Future<Null> processSignOutWithGoogle() async {
    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signOut().then((value) {
        print('Logout With Google Success');
      });
    });
  }
}
