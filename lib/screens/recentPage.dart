// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/btwProvider.dart';
import 'admin/butuanonWord.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BtwProvider>(context);
    final butuanonWords = provider.recentButuanonWords;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recent')
        ),
        body: ListView.builder(
            itemCount: butuanonWords.length,
            itemBuilder: (context, index) {
              // final btwWord = butuanonWords[index];
              return ListTile(
                leading: Icon(Icons.youtube_searched_for),
                onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ButuanonWord(
                                  displayWord: butuanonWords[index],
                                )));
                  },
                  title:  Text(
                    butuanonWords[index].btwWord,
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  trailing:  Icon(Icons.arrow_forward),
              );
            }));
  }
}
