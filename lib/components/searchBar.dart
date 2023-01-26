
import 'package:avatar_glow/avatar_glow.dart';
import 'package:butu1on_dictionary/provider/btwProvider.dart';
import 'package:butu1on_dictionary/utils/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../btw_wordModel.dart';
import '../main.dart';
import '../screens/admin/butuanonWord.dart';

class BtwSearchDelegate extends SearchDelegate {
  SpeechToText speechToText = SpeechToText();
  var isListening = false;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
      icon: const Icon(Icons.arrow_back));
  @override
  List<Widget>? buildActions(BuildContext context) => [
        StatefulBuilder(builder: (BuildContext context, setState) {
          return query.isEmpty
              ? AvatarGlow(
                  endRadius: 25.0,
                  animate: isListening,
                  duration: const Duration(milliseconds: 2000),
                  glowColor: Colors.white,
                  repeat: true,
                  repeatPauseDuration: const Duration(microseconds: 10),
                  showTwoGlows: true,
                  child: IconButton(
                      onPressed: () async {
                        // voiceSearch(context);
                        if (!isListening) {
                          var available = await speechToText.initialize();
                          if (available) {
                            setState(() {
                              isListening = true;
                              speechToText.listen(
                                onResult: (result) {
                                  setState(() {
                                    query = result.recognizedWords;
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
                            });
                          }
                        } else {
                          setState(() {
                            isListening = false;
                          });
                          speechToText.stop();
                        }
                      },
                      icon: Icon(isListening ? Icons.mic : Icons.mic_none)),
                )
              : IconButton(
                  onPressed: () {
                    query = '';
                  },
                  icon: const Icon(Icons.clear));
        })
      ];

  final _reference = FirebaseFirestore.instance.collection('butuanonWords');
  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _reference.snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
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
                    if (query.isEmpty) {
                      return ListTile(
                        leading: TextButton(
                          style: const ButtonStyle(
                              alignment: Alignment.centerLeft),
                          onPressed: () {
                            query = butuanon[index].btwWord;
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ButuanonWord(
                                      displayWord: butuanon[index],
                                    )));
                            // showResults(context);
                          },
                          child: Text(
                            butuanon[index].btwWord,
                            style: const TextStyle(
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
                        .startsWith(query.toLowerCase())) {
                      return ListTile(
                        leading: TextButton(
                          style: const ButtonStyle(
                              alignment: Alignment.centerLeft),
                          onPressed: () {
                            query = butuanon[index].btwWord;
                          
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ButuanonWord(
                                      displayWord: butuanon[index],
                                    )));
                          },
                          child: Text(
                            butuanon[index].btwWord,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    return Container();
                  });
        },
      );
  }
  
  // @override
  // Widget buildResults(BuildContext context) {
  //   final provider = Provider.of<BookmarkProvider>(context);

  //   return SingleChildScrollView(
  //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
  //         child: Card(
  //           elevation: 3,
  //           child: ListTile(
  //             title: Padding(
  //               padding: const EdgeInsets.only(left: 3),
  //               child: Text(
  //                 getbutuanon.btwWord,
  //                 style: const TextStyle(
  //                     color: Color(0xffFD7F2C),
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 20),
  //               ),
  //             ),
  //             subtitle: Padding(
  //               padding: const EdgeInsets.only(left: 3),
  //               child: Text(getbutuanon.partOfSpeech),
  //             ),
  //             trailing: SizedBox(
  //               width: 125,
  //               child: Row(children: [
  //                 Flexible(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           const InkWell(
  //                             child: Icon(
  //                               Icons.volume_up_outlined,
  //                               size: 30,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 5,
  //                           ),
  //                           Text(
  //                             getbutuanon.ipa,
  //                             style: const TextStyle(
  //                                 color: Colors.black54, fontSize: 12),
  //                           ),
  //                         ],
  //                       ),
  //                        InkWell(
  //                         onTap: () {
  //                           provider.toggleBookmark(getbutuanon);
  //                         },
  //                         child: provider.isExist(getbutuanon)
  //                         ?const Icon(Icons.bookmark_added_rounded,size: 25,color: themeColor,)
  //                         :const Icon(Icons.bookmark_add_outlined,size: 25,)
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ]),
  //             ),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 5,
  //       ),
  //       const Divider(
  //         thickness: 15,
  //         color: Color(0xffFD7F2C),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),

  //       const Padding(
  //         padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
  //         child: Text(
  //           'Definition:',
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //               color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Container(
  //         width: 400,
  //         color: Colors.blue.withOpacity(0.4),
  //         child: Padding(
  //           padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
  //           child: Text(
  //             getbutuanon.difinition,
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
  //         child: Text(
  //           'Translation:',
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //               color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       // Text(getbutuanon.audio),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'English: ${getbutuanon.transEnglish}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //             Text(
  //               'Tagalog: ${getbutuanon.transTagalog}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
  //         child: Text(
  //           'Sentences:',
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //               color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
  //         ),
  //       ),

  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'English: ${getbutuanon.engSentences}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //             Text(
  //               'Tagalog: ${getbutuanon.tagSentences}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //             Text(
  //               'Butuanon: ${getbutuanon.btwSentences}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
  //         child: Text(
  //           'Synonyms:',
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //               color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'English: ${getbutuanon.synEnglish}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //             Text(
  //               'Tagalog: ${getbutuanon.synTagalog}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
  //         child: Text(
  //           'Antonyms:',
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //               color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'English: ${getbutuanon.antEnglish}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //             Text(
  //               'Tagalog: ${getbutuanon.antTagalog}',
  //               style: const TextStyle(color: Colors.black),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ]),
  //   );
  // }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
