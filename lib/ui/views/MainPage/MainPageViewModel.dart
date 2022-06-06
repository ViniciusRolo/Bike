import 'dart:async';

import 'package:bike_observation_deck/API/API.dart';
import 'package:bike_observation_deck/API/Cache.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:http/http.dart' as http;

class MainPageViewModel extends BaseViewModel {
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

  var completeDateList;

  Future getTimeline() async {}
}
