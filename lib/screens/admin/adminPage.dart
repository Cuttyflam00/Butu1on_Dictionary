// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:butu1on_dictionary/btw_wordModel.dart';
import 'package:butu1on_dictionary/screens/admin/butuanonWord.dart';
import 'package:butu1on_dictionary/screens/admin/updateForm.dart';
import 'package:butu1on_dictionary/screens/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addForm.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
 
  final _reference = FirebaseFirestore.instance.collection('butuanonWords');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: <Widget>[
      //         navHeader(),
      //         navItems(),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Admin Page',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20)),
        elevation: 10,
      ),

      body: FutureBuilder<QuerySnapshot>(
        future: _reference.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Image.asset('assets/logo.png'),
                  Text(
                    'Something went wrong! ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            List<Butuanon> butuanon = documents
                .map((e) => Butuanon(
                    btwId: e['btwId'],
                    btwWord: e['btwWord'],
                    partOfSpeech: e['partOfSpeech'],
                    ipa: e['ipa'],
                    audio: e['audio'],
                    transEnglish: e['transEnglish'],
                    transTagalog: e['transTagalog'],
                    difinition: e['difinition'],
                    engSentences: e['engSentences'],
                    tagSentences: e['tagSentences'],
                    btwSentences: e['btwSentences'],
                    synEnglish: e['synEnglish'],
                    synTagalog: e['synTagalog'],
                    antEnglish: e['antEnglish'],
                    antTagalog: e['antTagalog']))
                .toList();
            return buildButuanon(butuanon);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      //add data form
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => AddForm(),
            );
          },
          child: Icon(Icons.add)),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          notchMargin: 5.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //home
              TextButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding:
                        MaterialStateProperty.all(EdgeInsets.only(right: 40))),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AdminPage()));
                },
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: Text('Home'),
                // color: Colors.white,
              ),

              //logout
              TextButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding:
                        MaterialStateProperty.all(EdgeInsets.only(left: 40))),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    log('Signed Out');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  });
                },
                icon: Icon(
                  Icons.logout_outlined,
                ),
                label: Text('Log Out'),
              ),
            ],
          )),
    );
  }

  Widget buildButuanon(butuanon) {
    return butuanon.isEmpty
        ? Center(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Image.asset('assets/logo.png'),
                Text(
                  'No Butuanon Word',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: butuanon.length,
            itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: TextButton(
                      style: ButtonStyle(alignment: Alignment.centerLeft),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ButuanonWord(
                                      displayWord: butuanon[index],
                                    )));
                      },
                      child: Text(
                        butuanon[index].btwWord,
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: SizedBox(
                        width: 60,
                        child: Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue.withOpacity(0.7),
                              ),
                              onTap: () {
                                log('edit');
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => UpdateForm(
                                        butuanonWord: butuanon[index]));
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red.withOpacity(0.7),
                              ),
                              onTap: () {
                                log('delete');
                                _reference.doc(butuanon[index].btwId).delete();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminPage()));
                              },
                            ),
                          ],
                        )),
                  ),
                ));

    // Widget navHeader() {
    //   return Container(
    //     decoration: BoxDecoration(
    //         gradient: LinearGradient(colors: const [
    //       Color(0x66FD7F2C),
    //       Color(0x99FD7F2C),
    //       Color(0xccFD7F2C),
    //       Color(0xffFD7F2C),
    //     ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    //     height: 255,
    //     padding: EdgeInsets.zero,
    //     child: SingleChildScrollView(
    //       child: Column(children: const [
    //         Image(
    //           image: AssetImage('assets/drawerlogo.png'),
    //         ),
    //       ]),
    //     ),
    //   );
    // }
    // Widget navItems() {
    //   return Container(
    //     padding: const EdgeInsets.all(10),
    //     child: Wrap(
    //       runSpacing: 2,
    //       children: [
    //         Center(
    //           child: Text(
    //             'Butu1non Dictionary',
    //             style: GoogleFonts.poppins(
    //               fontSize: 25,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 250,
    //         ),
    //         Divider(),
    //         SizedBox(
    //           height: 100,
    //         ),
    //         Align(
    //             alignment: Alignment.bottomRight,
    //             child: ElevatedButton.icon(
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.resolveWith((states) {
    //                   if (states.contains(MaterialState.pressed)) {
    //                     return Colors.redAccent;
    //                   }
    //                   return Color(0xffFD7F2C);
    //                 }),
    //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //                   RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(10.0),
    //                     side: BorderSide(
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               icon: Text('Log Out'),
    //               label: Icon(Icons.logout),
    //               onPressed: () {
    //                 FirebaseAuth.instance.signOut().then(
    //                   (value) {
    //                     print('Signed Out');
    //                     Navigator.push(context,
    //                         MaterialPageRoute(builder: (context) => LoginPage()));
    //                   },
    //                 );
    //               },
    //             ))
    //       ],
    //     ),
    // );
    // }
  }
}
