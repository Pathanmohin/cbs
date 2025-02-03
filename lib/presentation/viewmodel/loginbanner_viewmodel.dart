import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/repositories/auth_repository.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';


class LoginbannerViewmodel with ChangeNotifier {


    final _myRepo = AuthRepository();

  bool _setState = false;

  bool get loading => _setState;

  setStateScreen(bool value) {
    _setState = value;
    notifyListeners();
  }


  List<EVENTLIST> dashboardItemss = [];
    
  Future<void> loginbanner( dynamic data, dynamic header, BuildContext context) async {
    

    _myRepo.loginbanner(data, header, context).then((value) async {
     

      if (kDebugMode) {
        print(value);
      }

      print(value);
      
        var responseData = jsonDecode(value["Data"]);


        var result = value["Result"].toString();

        List<Map<String, dynamic>> beforeList = [];
        List<Map<String, dynamic>> afterList = [];

        if (result == "Success") {
          // List<dynamic> dataList = data;

          for (var item in responseData) {
            String festivalName = item['screentype'];

            if (festivalName == "beforeLogin") {
              beforeList.add(item);
            } else if (festivalName == "afterLogin") {
              afterList.add(item);
            }
          }

    
            BannerShowList.beforeList = beforeList.map((item) { return EVENTLIST.fromJson(item);}).toList();

            dashboardItemss = afterList.map((item) { return EVENTLIST.fromJson(item);}).toList();
        
           setStateScreen(true);
           
           BannerShowList.bannerList = dashboardItemss;
          
          // BannerShowList.dashboardEvent = true;

          

        }
      
    }).onError((error, stackTrace) {
      
       print(error.toString());
    });
  }
}
