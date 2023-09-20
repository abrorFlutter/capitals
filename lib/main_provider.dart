import 'package:botanika/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/database_helper.dart';
import 'models/word.dart';

class MainProvider extends ChangeNotifier{
  final List<Word> words = [];
  bool showCity = false;
  bool isDArk = false;

  initList({String? word,bool? isCity}) async{
    words.clear();
    if(word == null) {
      words.addAll( await DatabaseHelper.instance.getWords());
    } else{
      words.addAll( await DatabaseHelper.instance.getWordLike(word,isCity!));
    }
    notifyListeners();
  }

  change() {
    showCity = !showCity;
    notifyListeners();
  }

  Future<void> setDarkMode(bool dark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.Is_Database_Dark,dark);
  }

  Future<bool?> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(Constants.Is_Database_Dark)){
      return prefs.getBool(Constants.Is_Database_Dark);
    }
  }

}