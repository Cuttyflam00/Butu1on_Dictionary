import 'package:butu1on_dictionary/provider/bookmarkProvider.dart';
import 'package:butu1on_dictionary/screens/admin/butuanonWord.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookmarkProvider>(context);
    final butuanonWords = provider.butuanonWords;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
        ),
        body: ListView.builder(
            itemCount: butuanonWords.length,
            itemBuilder: (context, index) {
              // final btwWord = butuanonWords[index];
              return ListTile(
                leading: TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ButuanonWord(
                                  displayWord: butuanonWords[index],
                                )));
                  },
                  child: Text(
                    butuanonWords[index].btwWord,
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }));
  }
}
