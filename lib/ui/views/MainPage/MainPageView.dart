import 'dart:async';
import 'dart:ui';

import 'package:bike_observation_deck/models/Menu.dart';
import 'package:bike_observation_deck/ui/views/DetailPage/DetailPageView.dart';
import 'package:bike_observation_deck/ui/views/MainPage/MainPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:stacked/stacked.dart';

import '../../theme/AppColors.dart';

class MainPageView extends StatelessWidget {
  bool visible = false;
  String confirmedNumber = '';
  bool validNumber = false;

  //============= CONTROLLERS

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainPageViewModel>.reactive(
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
      viewModelBuilder: () => MainPageViewModel(),
      onModelReady: (model) async => [
        model.initData(),
      ],
    );
  }

  Widget _topBar(BuildContext context, MainPageViewModel model) {
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
                      "Main Page",
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

  Widget _centralContent(BuildContext context, MainPageViewModel model) {
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
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // print("$i");
                              // print(model.bikeData[i]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPageView(
                                        classInfo: model.bikeData[i]),
                                  ));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: AppColors.lightGray,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.bikeData[i]['name'].toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.darkGrey,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                          model.bikeData[i]['company']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.splashPink,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColors.gray,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: Text(
                                              "${model.bikeData[i]['location']['city']} - ${model.bikeData[i]['location']['country']} (Lat:${model.bikeData[i]['location']['latitude'].toStringAsFixed(2)} Long:${model.bikeData[i]['location']['longitude'].toStringAsFixed(2)})",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.darkGrey,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.01,
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

  Widget _bottomAppBar(BuildContext context, MainPageViewModel model) {
    return Positioned(
      //top: MediaQuery.of(context).size.height * 0.5,
      bottom: MediaQuery.of(context).size.height * 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Menu(
            home_: true,
          )
        ],
      ),
    );
  }
}
