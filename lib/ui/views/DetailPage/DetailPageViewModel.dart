import 'dart:async';

import 'package:bike_observation_deck/API/API.dart';
import 'package:bike_observation_deck/API/Cache.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:stacked/stacked.dart';

class DetailPageViewModel extends BaseViewModel {
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  var collectedData = {};
  var bikeData = [];
  var newBikeData;

  var detailedData = {};
  initData(id_Code) async {
    print("ID CODE: $id_Code");
    detailedData = await API().grabDetailData(id_Code);

    print("DETAILED DATA: $detailedData");
    notifyListeners();
  }
}
