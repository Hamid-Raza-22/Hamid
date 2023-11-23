import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'AppExceptions.dart';
import 'BaseApiServices.dart';
import 'package:http/http.dart' as http;

class ApiServices extends BaseApiServices {


  @override
  Future<dynamic> getApi(String url)async{

    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson ;
    try {

      final response = await http.get(Uri.parse(url)).timeout( const Duration(seconds: 10));
      responseJson  = jsonDecode(response.body) ;
      responseJson = responseJson['items'];
    }on SocketException {
      throw InternetException('');
    }on RequestTimeOut {
      throw RequestTimeOut('');

    }
    return responseJson ;
  }


  @override
  Future<dynamic> postApi(var data , String url)async{

    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson ;
    try {

      final response = await http.post(Uri.parse(url),
          body: data
      ).timeout( const Duration(seconds: 10));
      responseJson  = returnResponse(response) ;
    }on SocketException {
      print(InternetException(''));
    }on RequestTimeOut {
      print(RequestTimeOut(''));

    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson ;
  }

  Future<bool> masterPost(var data , String url) async{
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    try {

      final response = await http.post(Uri.parse(url),
          body: data
      ).timeout( const Duration(seconds: 10));

      if(response.statusCode == 200){
        return true;
      }else{
        print("ERROR ${response.statusCode.toString()}");
        return false;
      }
    }catch (Exception){
      print(Exception.toString());
      return false;
    }
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;

      default :
        throw FetchDataException('Error accoured while communicating with server '+response.statusCode.toString()) ;
    }
  }

}
