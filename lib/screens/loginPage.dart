// ignore_for_file: file_names, prefer_const_constructors, use_build_context_synchronously
// import 'package:google_fonts/google_fonts.dart';
import 'package:butu1on_dictionary/screens/auth_page.dart';
// import 'package:butu1on_dictionary/screens/signupPage.dart';
import 'package:butu1on_dictionary/utils/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  // void signUserIn()async{
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'LOG IN',
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
                        height: 50,
                      ),
                      Image.asset('assets/logo.png', fit: BoxFit.fitWidth),
                      // Text(
                      //   text,
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      reusetextField("Email", Icons.email_outlined, false,
                          _emailTextController),

                      SizedBox(
                        height: 20,
                      ),
                      reusetextField("Password", Icons.lock_outline, true,
                          _passwordTextController),
                      buildForgotPassBtn(),
                      signupLoginBtn(context, true, () async {
                        try {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                    child: CircularProgressIndicator());
                              });
                          
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AuthPage()));
                        } on FirebaseAuthException catch (error) {
                           Navigator.of(context).pop();
                        }
                      }),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Text(
                      //       "Don't have account?",
                      //       style: TextStyle(
                      //         color: Colors.white70,
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => SignUpPage()));
                      //       },
                      //       child: const Text(
                      //         " Sign Up",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     )
                      //   ],
                      // )
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
