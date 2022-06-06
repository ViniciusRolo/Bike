// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bike_observation_deck/API/Cache.dart';
import 'package:bike_observation_deck/ui/views/MainPage/MainPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';

import '../../../API/API.dart';
import 'SplashScreenView.dart';

class SplashScreenViewModel extends BaseViewModel {
  bool isLoading = false;

  var bikeData = {};
  initUserInfo(context) async {
    bikeData = (await API().grabFirstData());

    await Cache().saveHomepageData(bikeData);

    nextPath(context);
  }

  nextPath(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPageView()),
    );
  }

  logedInPath(context) {}
}
