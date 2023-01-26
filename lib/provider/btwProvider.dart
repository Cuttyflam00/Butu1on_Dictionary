import 'dart:developer';

import 'package:flutter/material.dart';

import '../btw_wordModel.dart';

class BtwProvider extends ChangeNotifier {

  //
  //Recent
  //
  final List<Butuanon> _recentbtwWords= [];
  final List<Butuanon> _bookmarkbtwWords = [];

  List<Butuanon> get recentButuanonWords => _recentbtwWords;

  void toggleRecent(Butuanon butuanon) {
    for (int i = 0; i < recentButuanonWords.length; i++) {
      if (recentButuanonWords[i]
          .btwWord
          .toString()
          .toLowerCase()
          .contains(butuanon.btwWord.toString().toLowerCase())) {
         _recentbtwWords.removeAt(i);

        break;
      }
    }

    if (recentButuanonWords.length < 20) {
      _recentbtwWords.add(butuanon);
      log('add to recent');
    } else {
      _recentbtwWords.removeAt(0);
      if (recentButuanonWords.length < 20) {
      _recentbtwWords.add(butuanon);
      log('add to recent');
    } 
    }
    notifyListeners();
  }


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
