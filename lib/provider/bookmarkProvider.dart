import 'dart:developer';

import 'package:flutter/material.dart';

import '../btw_wordModel.dart';

class BookmarkProvider extends ChangeNotifier {
  final List<Butuanon> _btwWords = [];

  List<Butuanon> get butuanonWords => _btwWords;
  void toggleBookmark(Butuanon butuanon) {
    var isExist = false;

    for (int i = 0; i < butuanonWords.length; i++) {
      if (butuanonWords[i]
          .btwWord
          .toString()
          .toLowerCase()
          .contains(butuanon.btwWord.toString().toLowerCase())) {
        isExist = true;
         _btwWords.removeAt(i);
        break;
      }else{
        isExist = false;
      }
    }
    if (isExist == true) {
      _btwWords.remove(butuanon);
      log('remove');
    } else {
      _btwWords.add(butuanon);
      log('add');
    }
    notifyListeners();
  }

  bool isExist(Butuanon butuanon) {
   var isExist = false;

    for (int i = 0; i < butuanonWords.length; i++) {
      if (butuanonWords[i]
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
