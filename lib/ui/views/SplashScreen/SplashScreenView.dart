import 'dart:async';

import 'package:bike_observation_deck/ui/theme/AppColors.dart';

import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'SplashScreenViewModel.dart';

class SplashScreenView extends StatelessWidget {
  bool visible = false;
  String confirmedNumber = '';
  bool validNumber = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.splashBlue,
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
      viewModelBuilder: () => SplashScreenViewModel(),
      onModelReady: (model) => [model.initUserInfo(context)],
    );
  }

  Widget _topBar(BuildContext context, SplashScreenViewModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 80, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, SplashScreenViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ================================================================================
              Image.asset(
                'Assets/splashLogo.gif',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                height: 30,
              ),
              Text(
                "WORLD BIKES",
                style: TextStyle(
                    color: AppColors.splashDarkBlue,
                    fontFamily: 'Inter',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBar(BuildContext context, SplashScreenViewModel model) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.02,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 30,
        ),
        child: Column(
          children: [
            Container(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
