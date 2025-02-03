// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/repositories/activate_repository.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/auth/login_view.dart';
import 'package:hpscb/utility/alertbox.dart';

class ActivateuserViewmodel with ChangeNotifier {
  final _myRepo = ActivateRepository();

  Future<void> activateuser(
      dynamic data, dynamic header, BuildContext context) async {
    // setLoading(true);

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    _myRepo.activateuser(data, header, context).then((value) async {
      Loader.hide();

      if (kDebugMode) {
        print(value);
      }

      Map<String, dynamic> responseData = jsonDecode(value);

      var a = jsonDecode(responseData["Data"].toString());
      var b = responseData["Result"].toString();

      if (b == "Success") {
        if (a["result"] == "success") {
          Loader.hide();
          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBoxWithButton(
                title: "Success",
                description: "Password Change Successfully..!!",
                onTapButton: () {

                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const LoginView())));
                  

                },
              );
            },
          );
        } else if (a['result'] == "-2") {
          Loader.hide();

          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "OTP Mismatch...!",
              );
            },
          );

          return;
        } else if (a['result'] == "-3") {
          Loader.hide();

          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "OTP has been expired..!",
              );
            },
          );

          return;
        } else {
          Loader.hide();

          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "This Account have not ATM Card No.",
              );
            },
          );

          return;
        }
      } else {
        Map<String, dynamic> responseData = jsonDecode(value);
        var a = jsonDecode(responseData["Data"].toString());
        var error = a['Error'].toString();

        await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: error.toString(),
            );
          },
        );

        return;
      }
    }).onError((error, stackTrace) {
      Loader.hide();
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> activateOTP(
      dynamic data, dynamic header, BuildContext context) async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    _myRepo.activateuserotp(data, header, context).then((value) async {
      Loader.hide();

      if (kDebugMode) {
        print(value);
      }

      Map<String, dynamic> responseData = jsonDecode(value);

      if (responseData["Result"].toString() == "Success") {
        var a = responseData["Data"];

        var data = AESencryption.decryptString(
          a,
          Constants.AESENCRYPTIONKEY,
        );

        Map<String, dynamic> dataa = jsonDecode(data);

        String authorise = dataa['authorise'];
        String userType = dataa['userType'];
        String validUser = dataa['validUser'];
        String customerId = dataa['customerId'];
        String sessionId = dataa['sessionId'];
        String custName = dataa['custName'];
        String lastLogin = dataa['lastlogin'];
        String mobileNo = dataa['mobileNo'];
        Loader.hide();

        if (authorise == "success") {
          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "OTP has been send to your Registered Mobile.",
              );
            },
          );

          return;
        } else {
          await showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Unable to Send OTP",
              );
            },
          );

          return;
        }
      } else {
        Loader.hide();

        await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: responseData["Message"].toString(),
            );
          },
        );

        return;
      }
    }).onError((error, stackTrace) {
      Loader.hide();
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
