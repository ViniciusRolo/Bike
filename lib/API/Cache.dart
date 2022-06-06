// ignore: file_names
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class Cache {
//=======================================================================
  saveHomepageData(homepageData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('homepageData', jsonEncode(homepageData).toString());
  }

  getHomepageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var homepageData = jsonDecode(prefs.getString('homepageData').toString());

    return homepageData;
  }

//=======================================================================
  setSearchHistory(history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('userHistory', history);
  }

  getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userHistory = (prefs.getStringList('userHistory'));

    return userHistory;
  }

//=======================================================================

}
