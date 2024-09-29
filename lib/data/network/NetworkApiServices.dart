
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../Exception.dart';
import 'BaseApiServices.dart';

class NetworkApiservices extends BaseapiServices {
//{'populate': 'categoryId','categoryId':'6589272a416445024fabcb7c'}
  //Get Api

  @override
  Future getGetApiresponse(String url, Map<String, String>header,{Map<String, dynamic>? queryParameters}) async {
    dynamic responseJson;

    try {
      final response = await http.get(Uri.parse(url).replace(queryParameters:queryParameters),headers: header).timeout(
          Duration(seconds: 5));
      responseJson = returnResponse(response);
    }
    on SocketException {
      throw InternetException("No Internet Connection");
    }
    return responseJson;
  }


  //PostAPi
  @override
  Future getPostApiresponse(String url, dynamic data,Map<String, String>header) async {
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
          body: jsonEncode(data), headers: header
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    }
    on SocketException {
      throw InternetException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPatchApi(String url, dynamic data, Map<String, String>header) async {
    dynamic responseJson;
    try {
      Response response = await http.patch(Uri.parse(url),
          body: jsonEncode(data), headers: header
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    }
    on SocketException {
      throw InternetException("No Internet Connection");
    }
    return responseJson;
  }


  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print("status code: ${response.statusCode}");
      print("body: ${response.body}");

    }

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        print(response.statusCode);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 204:
        return "";
      case 302:
        throw UnAuthorizedExceptions("you have no mobile data ");
      case 400:
        throw BadRequestExceptions(
            jsonDecode(response.body)["message"].toString());
      case 401:
        throw UnAuthorizedExceptions(
            jsonDecode(response.body)["message"].toString());
      case 404:
        throw NotFoundExceptions(
            jsonDecode(response.body)["message"].toString());
      case 409:
        throw ConflictingExceptions(
            jsonDecode(response.body)["message"].toString());
      case 429 :
        throw TooManyRequestsExceptions(
            response.body);
      case 500:
        throw ServerExceptions(jsonDecode(response.body)["message"].toString());
      case 503:
        throw ServiceUnavaibleExceptions(
            jsonDecode(response.body)["message"].toString());
      case 504:
        throw TimeoutExceptions(
            jsonDecode(response.body)["message"].toString());
      default:
        throw FatchDataExceptions(
            "Please check your internet connection : ${response.statusCode}");
    }
  }

  @override
  Future getPostApiresponseWithoutdata(String url, Map<String, String> header)async {
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
           headers: header
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    }
    on SocketException {
      throw InternetException("No Internet Connection");
    }
    return responseJson;
  }



}