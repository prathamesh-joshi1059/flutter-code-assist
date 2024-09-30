import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:work_permit_mobile_app/common/api/exception/custom_exception.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/flavor/app_config.dart';

class ApiProvider {
  static const int timeOutDuration = 20;

  Future<dynamic> get(String request, [String? token]) async {
    var responseJson = {};
    try {
      var url = Uri.parse(AppConfig.instance.baseUrl + request);
      String? bearerToken =
          await FirebaseAuth.instance.currentUser?.getIdToken(true);

      debugPrint("url->${AppConfig.instance.baseUrl + request}");
      debugPrint("bearerToken->$bearerToken");

      final response = await http.get(url, headers: {
        "content-type": "application/json",
        if (bearerToken != null && bearerToken.isNotEmpty)
          'Authorization': 'Bearer $bearerToken',
      }).timeout(const Duration(seconds: timeOutDuration));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(ValueString.noInternetConnection.toString());
    } on TimeoutException {
      throw APINotRespondingException();
    }
    return responseJson;
  }

  Future<dynamic> post(String request, Map? body) async {
    var responseJson = {};
    try {
      try {
        var url = Uri.parse(AppConfig.instance.baseUrl + request);
        String? bearerToken =
            await FirebaseAuth.instance.currentUser?.getIdToken(true);
        // print("post bearerToken->$bearerToken");
        debugPrint("url->${AppConfig.instance.baseUrl + request}");

        http.Response response;

        response = await http
            .post(url,
                headers: {
                  "content-type": "application/json",
                  'Authorization': 'Bearer $bearerToken',
                },
                body: jsonEncode(body))
            .timeout(const Duration(seconds: timeOutDuration));
        responseJson = _response(response);
        return responseJson;
      } catch (error) {
        // print("post error->$error");
        rethrow;
      }
    } on SocketException {
      throw FetchDataException(ValueString.noInternetConnection.toString());
    }
  }

  Future<dynamic> put(String request, Map body, [String? token]) async {
    var responseJson = {};
    try {
      var url = Uri.parse(AppConfig.instance.baseUrl + request);
      var bearerToken =
          await FirebaseAuth.instance.currentUser!.getIdToken(true);
      Map<String, String> headers = {
        "content-type": "application/json",
        'Authorization': 'Bearer $bearerToken',
      };
      final response = await http
          .put(url, headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: timeOutDuration));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException(ValueString.noInternetConnection.toString());
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    print("response : ${response.body}");

    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        throw BadRequestException(responseJson['data'].toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw BadResponseException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
