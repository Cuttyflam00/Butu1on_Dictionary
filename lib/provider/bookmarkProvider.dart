import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../btw_wordModel.dart';

class BookmarkProvider extends ChangeNotifier {
  final _reference = FirebaseFirestore.instance.collection('bookmark');


  void toggleBookmark(Butuanon butuanon) {
    var isExist = _reference.doc(butuanon.btwId);

    isExist.get().then((doc) async {
      if (doc.exists) {
       await _reference.doc(butuanon.btwId).delete();
        log('remove');
      } else {
        final addtoBookmark = _reference.doc(butuanon.btwId);
       await addtoBookmark.set(butuanon.toJson()).whenComplete(() {
          log('add');
        });
      }
    });
    notifyListeners();
  } 

}
