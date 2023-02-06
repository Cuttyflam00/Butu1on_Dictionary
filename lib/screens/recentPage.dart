// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../btw_wordModel.dart';
import 'admin/butuanonWord.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _reference = FirebaseFirestore.instance.collection('recent');
    return Scaffold(
        appBar: AppBar(title: const Text('Recent')),
        body: StreamBuilder<QuerySnapshot>(
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
                        return ListTile(
                          leading: Icon(Icons.youtube_searched_for),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ButuanonWord(
                                          displayWord: butuanon[index],
                                        )));
                          },
                          title: Text(
                            butuanon[index].btwWord,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward),
                        );
                      });
            }));
  }
}
