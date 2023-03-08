import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../btw_wordModel.dart';

class BookmarkProvider extends ChangeNotifier {

  Future<void> toggleBookmark(Butuanon butuanon) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(butuanon.btwId.toString());
    if (jsonString != null) {
      await prefs.remove(butuanon.btwId.toString());
      log('remove to bookmark');
    } else {
      await prefs.setString(butuanon.btwId.toString(), json.encode(butuanon));
      log('add to boookmark');
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> getAllBookmarkValues() async {
    final prefs = await SharedPreferences.getInstance();
    final getvalues = prefs.getKeys();
    final values = <String, dynamic>{};
    final keys = getvalues.where((element) => element != 'recentList');

    for (final key in keys) {
      final value = prefs.get(key);
      values[key] = value;
    }
    return values;
  }
}
