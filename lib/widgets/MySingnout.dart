// ignore_for_file: file_names, unnecessary_import, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_import, prefer_void_to_null, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodapp/HomePage.dart';
import 'package:foodapp/Login_page.dart';

class MySignOut extends StatelessWidget {
  const MySignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 120,
        ),
        ListTile(
          onTap: () async {
            GoogleSignIn _googleSignIn = GoogleSignIn(
              scopes: [
                'email',
                'https://www.googleapis.com/auth/contacts.readonly',
              ],
            );
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) async {
                await _googleSignIn.signOut().then((value) async {
                  return Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), (route) => false);
                });
              });
            });
          },
          leading: Icon(
            Icons.exit_to_app_outlined,
            color: Colors.white,
            size: 36,
          ),
          title: Text(
            'SignOut',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          tileColor: Colors.red,
        ),
      ],
    );
  }
}
