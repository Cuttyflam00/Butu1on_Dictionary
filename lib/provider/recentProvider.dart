import 'dart:developer';

import 'package:flutter/material.dart';

import '../btw_wordModel.dart';

class RecentProvider extends ChangeNotifier {

  //
  //Recent
  //
  final List<Butuanon> _recentbtwWords= [];

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

}
