// ignore_for_file: prefer_const_constructors
import 'package:butu1on_dictionary/components/searchBar.dart';
import 'package:butu1on_dictionary/provider/bookmarkProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:butu1on_dictionary/screens/NavBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookmarkProvider(),
      child: MaterialApp(
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
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  bool showBanner = true;

  @override
  Widget build(BuildContext context) {
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
                    suffixIcon: IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {},
                    ),
                    hintText: "Search...",
                    border: InputBorder.none),
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: BtwSearchDelegate(),
                  );
                },
                onChanged: (value) {
                  setState(() {
                    searchController.text = '';
                  });
                  showSearch(
                    context: context,
                    delegate: BtwSearchDelegate(),
                  );
                },
              ),
            ),
            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: _reference.snapshots(),
            //     builder: (context, snapshot) {
            //       return (snapshot.connectionState == ConnectionState.waiting)
            //           ? Center(
            //               child: CircularProgressIndicator(),
            //             )
            //           : ListView.builder(
            //               itemCount: snapshot.data!.docs.length,
            //               itemBuilder: (context, index) {
            //                 QuerySnapshot querySnapshot = snapshot.data!;
            //                 List<QueryDocumentSnapshot> documents =
            //                     querySnapshot.docs;

            //                 List<Butuanon> butuanon = documents
            //                     .map((e) => Butuanon(
            //                         btwId: e['btwId'],
            //                         btwWord: e['btwWord'],
            //                         partOfSpeech: e['partOfSpeech'],
            //                         ipa: e['ipa'],
            //                         audio: e['audio'],
            //                         transEnglish: e['transEnglish'],
            //                         transTagalog: e['transTagalog'],
            //                         difinition: e['difinition'],
            //                         engSentences: e['engSentences'],
            //                         tagSentences: e['tagSentences'],
            //                         btwSentences: e['btwSentences'],
            //                         synEnglish: e['synEnglish'],
            //                         synTagalog: e['synTagalog'],
            //                         antEnglish: e['antEnglish'],
            //                         antTagalog: e['antTagalog']))
            //                     .toList();
            //                 if (word.isEmpty) {
            //                   return ListTile(
            //                     leading: TextButton(
            //                       style: ButtonStyle(
            //                           alignment: Alignment.centerLeft),
            //                       onPressed: () {
            //                         Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                                 builder: (context) => ButuanonWord(
            //                                       displayWord: butuanon[index],
            //                                     )));
            //                       },
            //                       child: Text(
            //                         butuanon[index].btwWord,
            //                         style: TextStyle(
            //                             color: Colors.black54,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     ),
            //                   );
            //                 }
            //                 if (butuanon[index]
            //                     .btwWord
            //                     .toString()
            //                     .toLowerCase()
            //                     .startsWith(
            //                         word.toLowerCase())) {
            //                   return ListTile(
            //                     leading: TextButton(
            //                       style: ButtonStyle(
            //                           alignment: Alignment.centerLeft),
            //                       onPressed: () {
            //                         Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                                 builder: (context) => ButuanonWord(
            //                                       displayWord: butuanon[index],
            //                                     )));
            //                       },
            //                       child: Text(
            //                         butuanon[index].btwWord,
            //                         style: TextStyle(
            //                             color: Colors.black54,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     ),
            //                   );
            //                 }
            //                 return Container();
            //               });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
