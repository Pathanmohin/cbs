import 'package:flutter/material.dart';
import 'package:hpscb/data/network/BaseApiServices.dart';
import 'package:hpscb/data/network/NetworkApiServices.dart';
import 'package:hpscb/data/services/api_config.dart';

class DashboardRepository {

    final Baseapiservices _apiServices = Networkapiservices();

  Future<dynamic> fetchAccountDashboard(dynamic data,dynamic header, BuildContext context) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiConfig.fetchAccount, data, header,context);

      return response;
    } catch (e) {

      // ignore: use_rethrow_when_possible
      throw e;

    }
  }

  
}