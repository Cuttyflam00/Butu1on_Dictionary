// ignore_for_file: prefer_const_constructors
import 'package:butu1on_dictionary/provider/bookmarkProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'provider/recentProvider.dart';
import 'screens/homePage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final db = FirebaseFirestore.instance;
  db.settings = const Settings(persistenceEnabled: true);
  
  runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BookmarkProvider()),
    ChangeNotifierProvider(create: (context) => RecentProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Butu1on App',
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Color(0xffFD7F2C),
            circularTrackColor: Colors.blueGrey.withOpacity(0.50)),
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(color: Color(0xccFD7F2C)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}
