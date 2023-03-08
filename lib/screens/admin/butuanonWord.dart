import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../btw_wordModel.dart';
import '../../components/searchBar.dart';
import '../../provider/bookmarkProvider.dart';
import '../../utils/reusable_widget.dart';

class ButuanonWord extends StatefulWidget {
  final Butuanon displayWord;
  const ButuanonWord({super.key, required this.displayWord});

  @override
  State<ButuanonWord> createState() => _ButuanonWordState();
}

class _ButuanonWordState extends State<ButuanonWord> {
  final audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool bmark = false;

  @override
  void initState() {
    super.initState();
    checkIcon(widget.displayWord);
    if (widget.displayWord.audio != "null") {
      setSrc();
    }
  }

  Future<bool> checkIcon(Butuanon butuanon) async {
    final _prefs = await SharedPreferences.getInstance();
    final getbmark = _prefs.getString(butuanon.btwId.toString());
    if (getbmark != null) {
      setState(() {
        bmark = true;
      });
    } else {
      setState(() {
        bmark = false;
      });
    }
    return bmark;
  }

  setSrc() async {
    String url = '${widget.displayWord.audio.toString()}';
    await audioPlayer.setSourceUrl(url);
    audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  void dispose() {
    audioPlayer.dispose();
    bmark;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bprovider = Provider.of<BookmarkProvider>(context);

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.displayWord.srchBtwWord),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchBar()));
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                InkWell(
                                    onTap: () async {
                                      if (widget.displayWord.audio != "null") {
                                        setSrc();
                                        if (_isPlaying) {
                                          await audioPlayer.stop();
                                          setState(() {
                                            _isPlaying = false;
                                          });
                                        } else {
                                          await audioPlayer.resume();
                                          setState(() {
                                            _isPlaying = true;
                                          });
                                        }
                                      }
                                    },
                                    child: _isPlaying
                                        ? Icon(
                                            Icons.volume_up,
                                            size: 30,
                                            color: themeColor,
                                          )
                                        : Icon(
                                            Icons.volume_down,
                                            size: 30,
                                          )),
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
                                onTap: () async {
                                  bprovider.toggleBookmark(widget.displayWord);
                                  bmark = await checkIcon(widget.displayWord);
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  if (bmark) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Added to Bookmark',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: themeColor,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                         'Remove from Bookmark',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.blue,
                                    ));
                                  }
                                },
                                child: bmark
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
        ));
  }
}
