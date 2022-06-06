// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:bike_observation_deck/ui/views/MainPage/MainPageView.dart';
import 'package:bike_observation_deck/ui/views/Map/MapView.dart';
import 'package:bike_observation_deck/ui/views/Search/SearchView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

import '../API/Cache.dart';
import '../ui/theme/AppColors.dart';
import '../ui/views/SplashScreen/SplashScreenView.dart';

class Menu extends StatefulWidget {
  Menu({
    this.home_ = false,
    this.searchPage_ = false,
    this.map_ = false,
  });

  final bool home_;
  final bool searchPage_;
  final bool map_;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with WidgetsBindingObserver {
  bool _confirmEmail = false;

  @override
  Widget build(BuildContext context) {
    return menu;
  }

  // Language userLanguage;
  var pageLanguageData;
  var userData;

  initLanguage() {}
  initUserData() async {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // user = _sharedPrefService.loadProfileUser();

    initLanguage();
    initUserData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        WidgetsBinding.instance.removeObserver(this);
        //super.dispose();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => SplashScreenView(),
          ),
          (route) => false,
        );
        break;
      case AppLifecycleState.paused:
        WidgetsBinding.instance.removeObserver(this);
        //super.dispose();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => SplashScreenView(),
          ),
          (route) => false,
        );
        break;
      case AppLifecycleState.detached:
        WidgetsBinding.instance.removeObserver(this);
        //super.dispose();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => SplashScreenView(),
          ),
          (route) => false,
        );
        break;
      case AppLifecycleState.resumed:
        WidgetsBinding.instance.removeObserver(this);
        //super.dispose();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => SplashScreenView(),
          ),
          (route) => false,
        );
    }
  }

  Widget get menu {
    return Material(
      shadowColor: Colors.black,
      elevation: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xffF8F8FA), // @todo fix hex code
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  if (widget.home_ != true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPageView()),
                    );
                  }
                },
                color: AppColors.splashBlue,
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.home_ == true
                          ? Icon(
                              Icons.home_filled,
                              color: AppColors.darkBlue,
                            )
                          : Icon(
                              Icons.home_outlined,
                              color: AppColors.splashPink,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  if (widget.searchPage_ != true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchView()),
                    );
                  }
                },
                color: AppColors.splashBlue,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_outlined,
                        color: widget.searchPage_ == true
                            ? AppColors.darkBlue
                            : AppColors.splashPink,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  if (widget.map_ != true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapView()),
                    );
                  }
                },
                color: AppColors.splashBlue,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.map_ == true
                          ? Icon(
                              Icons.map,
                              color: AppColors.darkBlue,
                            )
                          : Icon(
                              Icons.map_outlined,
                              color: AppColors.splashPink,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
