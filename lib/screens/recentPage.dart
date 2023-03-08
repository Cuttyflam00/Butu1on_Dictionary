// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../btw_wordModel.dart';
import '../provider/recentProvider.dart';
import 'admin/butuanonWord.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});



  @override
  Widget build(BuildContext context) {
    final rprovider = Provider.of<RecentProvider>(context);
  
    return Scaffold(
        appBar: AppBar(title: const Text('Recent')),
        body: FutureBuilder(
          future: rprovider.getAllValues(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final values = snapshot.data as Map<String, dynamic>;
              
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    final key = values.keys.toList()[index];
                    // final value = values[key];
                    final decodeVal = json.decode(key);
                    Butuanon butuanon = Butuanon(
                        btwId: decodeVal['btwId'],
                        btwWord: decodeVal['btwWord'],
                        srchBtwWord: decodeVal['srchBtwWord'],
                        partOfSpeech: decodeVal['partOfSpeech'],
                        ipa: decodeVal['ipa'],
                        audio: decodeVal['audio'],
                        transEnglish: decodeVal['transEnglish'],
                        transTagalog: decodeVal['transTagalog'],
                        difinition: decodeVal['difinition'],
                        engSentences: decodeVal['engSentences'],
                        tagSentences: decodeVal['tagSentences'],
                        btwSentences: decodeVal['btwSentences'],
                        synEnglish: decodeVal['synEnglish'],
                        synTagalog: decodeVal['synTagalog'],
                        antEnglish: decodeVal['antEnglish'],
                        antTagalog: decodeVal['antTagalog']);

                    return ListTile(
                      leading: Icon(Icons.youtube_searched_for),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ButuanonWord(
                                      displayWord: butuanon,
                                    )));
                      },
                      title: Text(
                        butuanon.srchBtwWord,
                        // decodeVal['srchBtwWord'],
                        style: const TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
