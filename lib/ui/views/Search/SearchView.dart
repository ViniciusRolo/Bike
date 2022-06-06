import 'dart:async';

import 'dart:ui';

import 'package:bike_observation_deck/models/Menu.dart';
import 'package:bike_observation_deck/ui/theme/AppColors.dart';
import 'package:bike_observation_deck/ui/views/DetailPage/DetailPageView.dart';
import 'package:bike_observation_deck/ui/views/Search/SearchViewModel.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:stacked/stacked.dart';

import 'package:intl/intl.dart';

class SearchView extends StatelessWidget {
  SearchView({this.classInfo});

  final classInfo;

  //============= CONTROLLERS

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Focus(
                  focusNode: FocusNode(),
                  autofocus: false,
                  onFocusChange: (hasFocus) {
                    print('FOCUS CHANGED $hasFocus');

                    if (FocusScope.of(context).isFirstFocus) {
                      print('FOCUS CHANGED IS FIRST FOCUS $hasFocus');
                    }
                  },
                  child: _topBar(context, model)),
              _centralContent(context, model),
              _bottomAppBar(context, model),
            ],
          ),
        );
      },
      viewModelBuilder: () => SearchViewModel(),
      onModelReady: (model) => [
        model.initData(),
        model.getWeekTimeline(),
      ],
    );
  }

  Widget _topBar(BuildContext context, SearchViewModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 80, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: FloatingSearchBar(
              hint: 'search',
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 800),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              openAxisAlignment: 0.0,
              debounceDelay: const Duration(milliseconds: 500),
              backdropColor: Colors.transparent,
              onSubmitted: (query) {
                model.searchWeekly(query);
              },
              onQueryChanged: (query) {
                // Call your model, bloc, controller here.

                model.searchWeekly(query);
              },
              transition: CircularFloatingSearchBarTransition(),
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                FloatingSearchBarAction.searchToClear(
                  showIfClosed: false,
                ),
              ],
              builder: (context, transition) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _centralContent(BuildContext context, SearchViewModel model) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.60,
        child: Container(
          //color: Colors.red,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: model.searchResults.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        print(model.searchResults[i]);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPageView(
                                  classInfo: model.searchResults[i]),
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: AppColors.lightGray,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.13,
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
                                                  "${model.searchResults[i]["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 20,
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
                                                Icon(
                                                  Icons.book_outlined,
                                                  color: AppColors.darkGrey,
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${model.searchResults[i]["company"]}",
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
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: AppColors.darkGrey,
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${model.searchResults[i]["location"]['city']}",
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

  Widget _bottomAppBar(BuildContext context, SearchViewModel model) {
    return Positioned(
      //top: MediaQuery.of(context).size.height * 0.5,
      bottom: MediaQuery.of(context).size.height * 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Menu(
            searchPage_: true,
          )
        ],
      ),
    );
  }
}
