
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../btw_wordModel.dart';
import '../provider/recentProvider.dart';
import '../screens/admin/butuanonWord.dart';
import '../screens/homePage.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _ref = FirebaseFirestore.instance.collection('butuanonWords');
  final searchController = TextEditingController();
  SpeechToText speechToText = SpeechToText();

   @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  String query = '';
  var isListening = false;

  @override
  Widget build(BuildContext context) {
     final _reference = _ref.orderBy("srchBtwWord");
    final rprovider = Provider.of<RecentProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  )),
              icon: const Icon(Icons.arrow_back)),
          title: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            height: 38,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                hintText: "Search ...",
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            searchController.text = '';
                            query = '';
                          });
                        },
                        icon: const Icon(Icons.clear))
                    : null,
              ),
            ),
          ),
          actions: [
            query.isEmpty
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
                        icon: Icon(isListening ? Icons.mic : Icons.mic_none)))
                : Container(),
          ]),
      body:StreamBuilder<QuerySnapshot>(
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
                        List<QueryDocumentSnapshot> documents =
                            querySnapshot.docs;

                        List<Butuanon> butuanon = documents
                            .map((e) => Butuanon(
                                btwId: e['btwId'],
                                btwWord: e['btwWord'],
                                srchBtwWord: e['srchBtwWord'],
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
                              onPressed: () async{
                                rprovider.toggleRecent(butuanon[index]);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ButuanonWord(
                                              displayWord: butuanon[index],
                                            )));
                
                              },
                              child: Text(
                                butuanon[index].srchBtwWord,
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
                                rprovider.toggleRecent(butuanon[index]);
                            
                                query = butuanon[index].btwWord;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ButuanonWord(
                                              displayWord: butuanon[index],
                                            )));
                              },
                              child: Text(
                                butuanon[index].srchBtwWord,
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
          )
    );
  }
}
