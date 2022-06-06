import 'dart:async';
import 'dart:ui';

import 'package:bike_observation_deck/models/Menu.dart';

import 'package:bike_observation_deck/ui/views/Map/MapViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:stacked/stacked.dart';

import '../../theme/AppColors.dart';

class MapView extends StatelessWidget {
  bool visible = false;
  String confirmedNumber = '';
  bool validNumber = false;

  //============= CONTROLLERS

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _topBar(context, model),
              _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => MapViewModel(),
      onModelReady: (model) async => [
        await model.initData(),
      ],
    );
  }

  Widget _topBar(BuildContext context, MapViewModel model) {
    return Container(
      color: AppColors.splashBlue,
      //height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: EdgeInsets.fromLTRB(40, 80, 20, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.pedal_bike,
                        size: MediaQuery.of(context).size.width * 0.08),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                        //width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                      'WORLD BIKES',
                      // model.pageLanguageData["SIN-9-10"]
                      //     [model.userLanguage.language],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey,
                          fontSize: 26,
                          fontFamily: 'Roboto'),
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Container(
                        child: Text(
                      "Map Page",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 15,
                          fontFamily: 'Roboto'),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _centralContent(BuildContext context, MapViewModel model) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //========================================================================================
              Expanded(
                  child: ListView.builder(
                itemCount: model.bikeData.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GoogleMap(
                          //Map widget from google_maps_flutter package
                          zoomGesturesEnabled:
                              true, //enable Zoom in, out on map
                          initialCameraPosition: CameraPosition(
                            //innital position in map
                            target: model.showLocation, //initial position
                            zoom: 16.0, //initial zoom level
                          ),
                          markers: model.getmarkers(), //markers to show on map
                          mapType: MapType.normal,
                          cameraTargetBounds:
                              CameraTargetBounds.unbounded, //map type
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
                    ],
                  );
                },
              )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.085,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, MapViewModel model) {
    return Positioned(
      //top: MediaQuery.of(context).size.height * 0.5,
      bottom: MediaQuery.of(context).size.height * 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Menu(
            map_: true,
          )
        ],
      ),
    );
  }
}
