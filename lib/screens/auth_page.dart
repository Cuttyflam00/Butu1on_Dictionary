// ignore_for_file: prefer_const_constructors

import 'package:butu1on_dictionary/screens/admin/adminPage.dart';
import 'package:butu1on_dictionary/screens/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot) {
        if(snapshot.hasData){
          return AdminPage();
        }else{
          return LoginPage();
        }
      },),
    );
  }
}