// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:butu1on_dictionary/screens/admin/adminPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/reusable_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _userTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: const [
                  Color(0x66FD7F2C),
                  Color(0x99FD7F2C),
                  Color(0xccFD7F2C),
                  Color(0xffFD7F2C),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      reusetextField("Enter Username", Icons.person_outline,
                          false, _userTextController),
                      SizedBox(
                        height: 20,
                      ),
                      reusetextField("Enter Email", Icons.email_outlined, false,
                          _emailTextController),
                      SizedBox(
                        height: 20,
                      ),
                      reusetextField("Enter Password", Icons.lock_outline, true,
                          _passwordTextController),
                      SizedBox(
                        height: 20,
                      ),
                      signupLoginBtn(context, false, () async {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text);
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => AdminPage()));
                        } on FirebaseAuthException catch (error) {
                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.message.toString()),
                            )
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
