import 'dart:async';

import 'package:bike_observation_deck/API/API.dart';
import 'package:bike_observation_deck/API/Cache.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class MapViewModel extends BaseViewModel {
  var collectedData = {};
  var bikeData = [];
  var newBikeData;
  late Position position;
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = {}; //markers for google map
  LatLng showLocation = const LatLng(0, 0);

  Set<Marker> getmarkers() {
    //markers to place on map

    markers.add(Marker(
      //add first marker
      markerId: MarkerId(showLocation.toString()),
      position:
          LatLng(position.latitude, position.longitude), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'You are Here',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    for (var k in bikeData) {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(k['location']['latitude'],
            k['location']['longitude']), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: '${k['name']}',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    }

    //add more markers here

    return markers;
  }

  initData() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    notifyListeners();
    print("POSITION: $position");
    showLocation = LatLng(position.latitude, position.longitude);
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
