

import 'package:flutter/src/widgets/framework.dart';

abstract class Baseapiservices {

Future<dynamic> getGetApiResponse(String url);

Future<dynamic> getPostApiResponse(String url,dynamic data,dynamic header, BuildContext context);

Future<dynamic> getPostApiBanner(String url,dynamic data,dynamic header, BuildContext context);

}