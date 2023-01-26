import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../btw_wordModel.dart';
import '../../components/searchBar.dart';
import '../../provider/btwProvider.dart';
import '../../utils/reusable_widget.dart';

class ButuanonWord extends StatefulWidget {
  final Butuanon displayWord;
  const ButuanonWord({super.key, required this.displayWord});

  @override
  State<ButuanonWord> createState() => _ButuanonWordState();
}

class _ButuanonWordState extends State<ButuanonWord> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BtwProvider>(context);

    //add to recent
     provider.toggleRecent(widget.displayWord);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.displayWord.btwWord),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: BtwSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    widget.displayWord.btwWord,
                    style: const TextStyle(
                        color: Color(0xffFD7F2C),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(widget.displayWord.partOfSpeech),
                ),
                trailing: SizedBox(
                  width: 125,
                  child: Row(children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const InkWell(
                                child: Icon(
                                  Icons.volume_up_outlined,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.displayWord.ipa,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                provider.toggleBookmark(widget.displayWord);
                              },
                              child: provider.isExist(widget.displayWord)
                                  ? const Icon(
                                      Icons.bookmark_added_rounded,
                                      size: 25,
                                      color: themeColor,
                                    )
                                  : const Icon(
                                      Icons.bookmark_add_outlined,
                                      size: 25,
                                    ))
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 15,
            color: Color(0xffFD7F2C),
          ),
          const SizedBox(
            height: 10,
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
            child: Text(
              'Definition:',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 400,
            color: Colors.blue.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
              child: Text(widget.displayWord.difinition),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
            child: Text(
              'Translation:',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
            ),
          ),
          // Text(widget.displayWord.audio),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'English: ${widget.displayWord.transEnglish}',
                  style: const TextStyle(color: Colors.black),
                ),
                Text('Tagalog: ${widget.displayWord.transTagalog}'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
            child: Text(
              'Sentences:',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('English: ${widget.displayWord.engSentences}'),
                Text('Tagalog: ${widget.displayWord.tagSentences}'),
                Text('Butuanon: ${widget.displayWord.btwSentences}'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
            child: Text(
              'Synonyms:',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('English: ${widget.displayWord.synEnglish}'),
                Text('Tagalog: ${widget.displayWord.synTagalog}'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 8, 30, 5),
            child: Text(
              'Antonyms:',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xffFD7F2C), fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('English: ${widget.displayWord.antEnglish}'),
                Text('Tagalog: ${widget.displayWord.antTagalog}'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
