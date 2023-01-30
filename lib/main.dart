// ignore_for_file: prefer_const_constructors
import 'package:avatar_glow/avatar_glow.dart';
import 'package:butu1on_dictionary/provider/bookmarkProvider.dart';
import 'package:butu1on_dictionary/utils/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:butu1on_dictionary/screens/NavBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'btw_wordModel.dart';
import 'provider/recentProvider.dart';
import 'screens/admin/butuanonWord.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _reference = FirebaseFirestore.instance.collection('butuanonWords');
  SpeechToText speechToText = SpeechToText();
  String query = '';
  var isListening = false;
  final searchController = TextEditingController();
  bool showBanner = true;

  @override
  Widget build(BuildContext context) {

     final rprovider = Provider.of<RecentProvider>(context);
     
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        // flexibleSpace: Container(
        //    decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: const [
        //   Color(0xffFD7F2C),
        //   Colors.orangeAccent,// Color(0x99FD7F2C),
        // // Color(0xccFD7F2C),
        //   Color(0xffFD7F2C),
        //     Colors.deepOrangeAccent,
        // ], ),),
        // ),
        title: Text('Butu1on Dictionary',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20)),
        elevation: 10,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            showBanner ? Image.asset('assets/logo.png') : Container(),

            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: query.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = '';
                                query = '';
                                showBanner = true;
                              });
                            },
                            icon: const Icon(Icons.clear))
                        : AvatarGlow(
                    endRadius: 25.0,
                    animate: isListening,
                    duration: const Duration(milliseconds: 2000),
                    glowColor: themeColor,
                    repeat: true,
                    repeatPauseDuration: const Duration(microseconds: 10),
                    showTwoGlows: true,
                    child: IconButton(
                        onPressed: () async {
                          if (!isListening) {
                            var available = await speechToText.initialize();
                            if (available) {
                              setState(() {
                                isListening = true;
                              });
                              speechToText.listen(
                                onResult: (result) {
                                  setState(() {
                                    query = result.recognizedWords;
                                    searchController.text = query;
                                  });
                                  speechToText.stop();
                                },
                                onSoundLevelChange: (level) async {
                                  var dur = await Future.delayed(
                                      const Duration(seconds: 6));
                                  if (dur == null) {
                                    if (level.isNegative) {
                                      setState(() {
                                        isListening = false;
                                      });
                                      speechToText.stop();
                                    }
                                  }
                                },
                                cancelOnError: true,
                              );
                            }
                          } else {
                            setState(() {
                              isListening = false;
                            });
                            speechToText.stop();
                          }
                        },
                        icon: Icon(isListening ? Icons.mic : Icons.mic_none))),
                    hintText: "Search...",
                    border: InputBorder.none),
                onChanged: (value) {
                  setState(() {
                    query = value;
                    showBanner = false;
                  });
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _reference.snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            QuerySnapshot querySnapshot = snapshot.data!;
                            List<QueryDocumentSnapshot> documents =
                                querySnapshot.docs;

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
                            if (query.isEmpty) {
                              return ListTile(
                                leading: TextButton(
                                  style: ButtonStyle(
                                      alignment: Alignment.centerLeft),
                                  onPressed: () {
                                     rprovider.toggleRecent(butuanon[index]);
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
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }
                            if (butuanon[index]
                                .btwWord
                                .toString()
                                .toLowerCase()
                                .startsWith(
                                    query.toLowerCase())) {
                              return ListTile(
                                leading: TextButton(
                                  style: ButtonStyle(
                                      alignment: Alignment.centerLeft),
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
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
