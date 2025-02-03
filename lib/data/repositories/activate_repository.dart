import 'package:flutter/material.dart';
import 'package:hpscb/data/network/BaseApiServices.dart';
import 'package:hpscb/data/network/NetworkApiServices.dart';
import 'package:hpscb/data/services/api_config.dart';

class ActivateRepository {
  
    final Baseapiservices _apiServices = Networkapiservices();

  Future<dynamic> activateuser(dynamic data,dynamic header, BuildContext context) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiConfig.passwordchange, data, header,context);

      return response;
    } catch (e) {

      throw e;

    }
  }

    Future<dynamic> activateuserotp(dynamic data,dynamic header, BuildContext context) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiConfig.passCon, data, header,context);

      return response;
    } catch (e) {

      throw e;

    }
  }



  
}