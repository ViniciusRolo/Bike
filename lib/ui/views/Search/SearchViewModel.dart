import 'dart:async';

import 'package:bike_observation_deck/API/API.dart';
import 'package:bike_observation_deck/API/Cache.dart';
import 'package:bike_observation_deck/ui/theme/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  bool keyboardShow = true;

  Future getWeekTimeline() async {
    notifyListeners();
  }

  List searchResults = [];

  searchClasses() async {}

  searchWeekly(query) async {
    searchResults = [];
    notifyListeners();
    for (var i in bikeData) {
      if (i['location']['city']
          .toString()
          .toLowerCase()
          .contains(query.toString().toLowerCase())) {
        searchResults.add(i);
      }
      if (i['name']
          .toString()
          .toLowerCase()
          .contains(query.toString().toLowerCase())) {
        searchResults.add(i);
      }
      if (i['company'][0]
          .toString()
          .toLowerCase()
          .contains(query.toString().toLowerCase())) {
        searchResults.add(i);
      }
      if (i['attribute']
          .toString()
          .toLowerCase()
          .contains(query.toString().toLowerCase())) {
        searchResults.add(i);
      }

      if (i['location']['country']
          .toString()
          .toLowerCase()
          .contains(query.toString().toLowerCase())) {
        searchResults.add(i);
      }
    }

    searchResults = List.from(searchResults.reversed);

    notifyListeners();
  }

  var collectedData = {};
  var bikeData = [];
  var newBikeData;

  initData() async {
    notifyListeners();
    collectedData = await Cache().getHomepageData();
    bikeData = (collectedData['networks']);
    notifyListeners();
    bikeData = (await API().grabFirstData());
    await Cache().saveHomepageData(bikeData);
    notifyListeners();
  }

  bool isLoading = false;
}
