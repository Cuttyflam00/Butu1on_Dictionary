import 'dart:developer';

import 'package:flutter/material.dart';

import '../btw_wordModel.dart';

class BookmarkProvider extends ChangeNotifier {

  final List<Butuanon> _bookmarkbtwWords = [];

  //
  //BookMark
  //

  List<Butuanon> get bookmarkButuanonWords => _bookmarkbtwWords;
  void toggleBookmark(Butuanon butuanon) {
    var isExist = false;

    for (int i = 0; i < bookmarkButuanonWords.length; i++) {
      if (bookmarkButuanonWords[i]
          .btwWord
          .toString()
          .toLowerCase()
          .contains(butuanon.btwWord.toString().toLowerCase())) {
        isExist = true;
         _bookmarkbtwWords.removeAt(i);
        break;
      }else{
        isExist = false;
      }
    }
    if (isExist == true) {
      _bookmarkbtwWords.remove(butuanon);
      log('remove');
    } else {
      _bookmarkbtwWords.add(butuanon);
      log('add');
    }
    notifyListeners();
  }

  bool isExist(Butuanon butuanon) {
   var isExist = false;

    for (int i = 0; i < bookmarkButuanonWords.length; i++) {
      if (bookmarkButuanonWords[i]
          .btwWord
          .toString()
          .toLowerCase()
          .contains(butuanon.btwWord.toString().toLowerCase())) {
        isExist = true;
        break;
      }else{
        isExist = false;
      }
    }
    return isExist;
  }
}
