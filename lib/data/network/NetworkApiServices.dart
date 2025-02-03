import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/data/app_exception.dart';
import 'package:hpscb/data/network/BaseApiServices.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Networkapiservices extends Baseapiservices {


  @override
  Future getGetApiResponse(String url) async{

    dynamic responseJson;
    
    try {

      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
         
    } on SocketException {
       
       throw FetchDataException('No Internet Connection');

    }

    return responseJson;

  }



  @override
  Future getPostApiResponse(String url,dynamic data,dynamic header,BuildContext context) async{
    
    dynamic responseJson;
    
    try {

      Response response = await post(
        Uri.parse(url),
        body: data,
        headers: header,
        encoding: Encoding.getByName('utf-8'),
        ).timeout(const Duration(seconds: 20));
      
      
      responseJson = returnResponse(response);



         
    } catch (e) {
       
       //throw FetchDataException('No Internet Connection');

          //        await Utils.alertBox(
          //     "Alert",
          //     e.toString(),
          //     // ignore: use_build_context_synchronously
          //     context, () {
          //   Navigator.of(context).pop();
          // });

          if(e.toString() == "TimeoutException after 0:00:20.000000: Future not completed"){

             Loader.hide();

            await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description:
                   "Unable to connect with server",
              );
            },
          );
          return;

          }else{

                 if (kDebugMode) {
                   print(e.toString());
                 }

          Loader.hide();

            await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description:
                   e.toString(),
              );
            },
          );
          return;

          }

        

    }

    return responseJson;
  }


 @override
  Future getPostApiBanner(String url,dynamic data,dynamic header,BuildContext context) async{
    
    dynamic responseJson;
    
    try {

      Response response = await post(
        Uri.parse(url),
        body: data,
        headers: header,
        encoding: Encoding.getByName('utf-8'),
        ).timeout(const Duration(seconds: 20));
      
      
      responseJson = returnResponse(response);



         
    } catch (e) {
       
       throw FetchDataException('No Internet Connection');

        

    }

    return responseJson;
  }



  dynamic returnResponse (http.Response response){

    switch (response.statusCode) {
      case 200:
      //throw BadRequestException('Bad request: ${response.body}');
         dynamic responseJson = jsonDecode(response.body);
         return responseJson;

    case 400:
      
      
      // throw BadRequestException('Bad request: ${response.body}');

      throw BadRequestException('Unable to connect with server.');


    case 401:
    case 403:

    
      //throw UnauthorizedException('Unauthorized access: ${response.body}');
throw UnauthorizedException('Unauthorized access');

    case 404:
     // throw FetchDataException('Not found: ${response.body}');
     throw FetchDataException('Data Not found');

    case 500:
    case 502:
    case 503:
    case 504:
     // throw ServerException('Server error: ${response.statusCode}, ${response.body}');
     throw ServerException('Server error: ${response.statusCode}');

      default:
         throw FetchDataException('Error occured while communicating with server with status code ${response.statusCode}');
    }

  }


}