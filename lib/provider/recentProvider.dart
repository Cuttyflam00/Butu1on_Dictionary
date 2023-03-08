import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../btw_wordModel.dart';

class RecentProvider extends ChangeNotifier {
  //
  //Recent
  //
  final List<Butuanon> recents = [];

  void toggleRecent(Butuanon butuanon) {
    var isExist = false;
    if (recents.length <= 10) {
      for (int i = 0; i < recents.length; i++) {
        if (recents[i]
            .btwId
            .toString()
            .toLowerCase()
            .contains(butuanon.btwId.toString().toLowerCase())) {
          isExist = true;
          recents.removeAt(i);
          log('remove');
          if (recents.length <= 10) {
            recents.add(butuanon);
            log('add');
          }
          break;
        } else {
          isExist = false;
        }
      }
      if (isExist == false) {
        recents.add(butuanon);
        log('add');
      }
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> getAllValues() async {
    final values = <String, dynamic>{};
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (recents.isNotEmpty) {
      await prefs.setString('recentList', json.encode(recents));
    }
    final _prefs = prefs.getString('recentList');
    if (_prefs != null) {
      final keys = json.decode(_prefs);
      for (var key in keys) {
        final val = json.encode(key);
        final value = prefs.get(val);
        values[val] = value;
      }
    } else {
      return values;
    }

    return values;
  }
}
