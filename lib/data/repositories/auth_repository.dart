import 'package:flutter/material.dart';
import 'package:hpscb/data/network/BaseApiServices.dart';
import 'package:hpscb/data/network/NetworkApiServices.dart';
import 'package:hpscb/data/services/api_config.dart';

class AuthRepository {
  final Baseapiservices _apiServices = Networkapiservices();

  Future<dynamic> loginApi(
      dynamic data, dynamic header, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiConfig.loginauth, data, header, context);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loginWithMPINApi(
      dynamic data, dynamic header, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiConfig.loginauth, data, header, context);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> contactus(
      dynamic data, dynamic header, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiConfig.contactus, data, header, context);

      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  Future<dynamic> loginbanner(
      dynamic data, dynamic header, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiBanner(
          ApiConfig.banLogin, data, header, context);

      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  Future<dynamic> Saftytipsss(
      dynamic data, dynamic header, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiBanner(
          ApiConfig.tipess, data, header, context);

      return response;
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }
}
