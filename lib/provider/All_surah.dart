import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quran/quran.dart' as quran;

class AllSu with ChangeNotifier {
  void getOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    notifyListeners();
  }

  int ver = 0;

  getVerseCount(int i) {
    return ver = quran.getVerseCount(i + 1);
  }

  String basmla = '';

  getBasmla() {
    basmla = quran.basmala;
    notifyListeners();
  }

  getPlaceOfRevelationByIndex(int i) {
    String verses = "";
    verses += quran.getPlaceOfRevelation(i + 1);

    return verses;
  }

  getAllVerses(surah) {
    String allVerses = '';

    for (int i = 0; i < quran.getVerseCount(surah); i++) {
      allVerses = allVerses +
          '${quran.getVerse(surah, i + 1)} ${[i + 1]} ' /* + ' ${[i+1]} '*/;
    }

    return allVerses;

  }



}
