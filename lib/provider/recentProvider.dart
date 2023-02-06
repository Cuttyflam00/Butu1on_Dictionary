import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../btw_wordModel.dart';

class RecentProvider extends ChangeNotifier {
  //
  //Recent
  //
  final _reference = FirebaseFirestore.instance.collection('recent');

  void toggleRecent(Butuanon butuanon) {
    var isExist = _reference.doc(butuanon.btwId);
    isExist.get().then((doc) async {
      if (doc.exists) {
        await _reference.doc(butuanon.btwId).delete();
        log('remove to recent');
        await _reference.get().then((QuerySnapshot snapshot) {
          int documentCount = snapshot.docs.length;
          if (documentCount < 10) {
            final addtoBookmark = _reference.doc(butuanon.btwId);
            addtoBookmark.set(butuanon.toJson()).whenComplete(() {
              log('add to recent');
            });
          }
        });
      } else {
        final addtoBookmark = _reference.doc(butuanon.btwId);
        addtoBookmark.set(butuanon.toJson()).whenComplete(() {
          log('add to recent');
        });
      }
    });
    notifyListeners();
  }
}
