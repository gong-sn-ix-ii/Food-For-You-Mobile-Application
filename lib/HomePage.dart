// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, file_names, unused_import, duplicate_import, unnecessary_string_escapes, unnecessary_new

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Login_page.dart';
import 'package:foodapp/register_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Color.fromARGB(255, 255, 255, 255),
                  Colors.white,
                ]),
          ),
          child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0),
              body: SafeArea(
                  child: Column(
                children: [
                  Center(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 120, 0, 70),
                          child: Container(
                              child: Image.asset('assets/image_use/Logo.png' , width: MediaQuery.of(context).size.width / 1.4,)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: 300,
                        height: 37,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.login,
                            color: Colors.black,
                          ),
                          label: Text(
                            ' เข้าสู่ระบบ ',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 160, 43))),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: 300,
                        height: 37,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.manage_accounts,
                            color: Colors.black,
                          ),
                          label: Text(
                            'สมัครบัญชี',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterAccount()));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 83, 220, 254))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                        Text(
                          'พบเจอปัญหา',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // ignore: deprecated_member_use
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                width: 2,
                                color: Colors.black,
                              )),
                          child: Text(
                            'ติดต่อปัญหา',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 1,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Email : G_d20sep09Y02@hotmail.com Tell : 09X-XXX-XXXX',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ))),
        ));
  }
}
