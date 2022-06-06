import 'dart:async';

import 'dart:ui';

import 'package:bike_observation_deck/ui/theme/AppColors.dart';
import 'package:bike_observation_deck/ui/views/DetailPage/DetailPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:stacked/stacked.dart';

import 'package:intl/intl.dart';

class DetailPageView extends StatelessWidget {
  DetailPageView({this.classInfo});

  final classInfo;

  //============= CONTROLLERS

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailPageViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _topBar(context, model),
              _centralContent(context, model),
              // _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => DetailPageViewModel(),
      onModelReady: (model) async => [
        {print(classInfo['id'])},
        await model.initData(classInfo['id']),
      ],
    );
  }

  Widget _topBar(BuildContext context, DetailPageViewModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 80, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerLeft,
            child: IconButton(
              iconSize: MediaQuery.of(context).size.width * 0.067,
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.gray,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  model.detailedData['name'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.splashDarkBlue,
                      fontSize: 38,
                      fontFamily: 'Roboto'),
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            model.detailedData['company'].toString(),
            style: TextStyle(
                color: AppColors.splashPink, fontSize: 20, fontFamily: "inter"),
          ),
          Text(
            "${classInfo['location']['city']} - ${classInfo['location']['country']}",
            style: TextStyle(
                color: AppColors.darkGrey, fontSize: 20, fontFamily: "inter"),
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, DetailPageViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: GoogleMap(
                  //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition(
                    //innital position in map
                    target: LatLng(classInfo['location']['latitude'],
                        classInfo['location']['longitude']), //initial position
                    zoom: 16.0, //initial zoom level
                  ),
                  markers: {
                    Marker(
                      //add first marker
                      markerId: MarkerId('local'),
                      position: LatLng(
                          classInfo['location']['latitude'],
                          classInfo['location']
                              ['longitude']), //position of marker
                      infoWindow: InfoWindow(
                        //popup info
                        title: classInfo['name'],
                      ),
                      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
                    )
                  },
                  mapType: MapType.normal,
                  cameraTargetBounds: CameraTargetBounds.unbounded, //map type
                  onMapCreated: (controller) {
                    //method called when map is created
                    model.mapController = controller;
                    model.notifyListeners();
                  },
                  onCameraMove: (controller) {
                    model.notifyListeners();
                  },
                ),
              ),
              Container(
                height: 10,
              ),
              Text(
                "Stations",
                style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 20,
                    fontFamily: "inter"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: model.detailedData['stations'].length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGray,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.15,
                              alignment: Alignment.center,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${model.detailedData['stations'][i]['name']}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "empty slots: ${model.detailedData['stations'][i]['empty_slots']}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                    color: AppColors.darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Free Bikes: ${model.detailedData['stations'][i]['free_bikes']}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                    color: AppColors.darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "timestamp: ${model.detailedData['stations'][i]['timestamp']}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Inter',
                                                    color: AppColors.darkGrey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.04),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, DetailPageViewModel model) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.02,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
