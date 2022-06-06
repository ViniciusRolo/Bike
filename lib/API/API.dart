import 'dart:async';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class API {
  //=================================
  var header_common = <String, String>{
    'Content-Type': 'application/json',
    'Accept': "*/*",
    'connection': 'keep-alive',
    'Accept-Encoding': 'gzip, deflate, br',
    'host': 'ipv4',
  };

  var production_uri = "http://api.citybik.es/v2/networks/";

  grabFirstData() async {
    var registerInfo = {};
    await http
        .get(
          Uri.parse('${production_uri}').replace(queryParameters: {}, port: 80),
          headers: header_common,
        )
        .then((response) => registerInfo = (jsonDecode(response.body)))
        .catchError((error) => print(error));
    return registerInfo;
  }

  grabDetailData(id_search) async {
    var registerInfo = {};
    await http
        .get(
          Uri.parse('${production_uri}$id_search')
              .replace(queryParameters: {}, port: 80),
          headers: header_common,
        )
        .then((response) => registerInfo = (jsonDecode(response.body)))
        .catchError((error) => print(error));
    return registerInfo["network"];
  }
}
