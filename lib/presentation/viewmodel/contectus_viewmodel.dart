import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/data/models/ContactInfo.dart';
import 'package:hpscb/data/repositories/auth_repository.dart';
import 'package:hpscb/presentation/view/auth/contactus/contactus.dart';

class ContactusViewmodel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> contactus(
      dynamic data, dynamic header, BuildContext context) async {
    // setLoading(true);

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    _myRepo.contactus(data, header, context).then((value) async {
      Loader.hide();

      if (kDebugMode) {
        print(value);
      }
       
        //var responseData = jsonDecode(value);

        var json = value["message"];
      
    List<dynamic> jsonData = jsonDecode(json);

    print(jsonData);

    var data = jsonData[0];

      ContactInfo contactInfo = ContactInfo.fromJson(data);
       
       Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(contactInfo: contactInfo)));
        print(contactInfo);
        

    }).onError((error, stackTrace) {
      Loader.hide();
       print(error.toString());
    });
  }
}
