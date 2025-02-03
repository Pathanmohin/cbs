// ignore_for_file: use_build_context_synchronously, unused_local_variable, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:hpscb/data/repositories/auth_repository.dart';

class SaftytipssViewmodel with ChangeNotifier {
  final _myRepo = AuthRepository();

  // bool _setState = false;

  // bool get loading => _setState;
  // setStateScreen(bool value) {
  //   _setState = value;
  //   notifyListeners();
  // }

  Future<void> SaftytippApi(
      dynamic data, dynamic header, BuildContext context) async {
    // setLoading(true);

    // Loader.show(context, progressIndicator: const CircularProgressIndicator());

    _myRepo.Saftytipsss(data, header, context).then((value) async {
      // Loader.hide();

      if (kDebugMode) {
        //print(value);
      }

      // var responseData = jsonDecode(value);

      // var json = value["message"];

      // List<dynamic> jsonData = jsonDecode(json);

      // print(jsonData);

      // var data = jsonData[0];

      try {
        // Make POST request

        // Check if request was successful
        // if (response.statusCode == 200) {
        // Map<String, dynamic> responseData = jsonDecode(response.body);

        // Access the first item in the list and its safety_remark field
        var data = jsonDecode(value["Data"].toString());

        // Access the first item in the list and its safety_remark field
        var safetyRemark = data[0]["safety_remark"];
        var safetyKid = data[0]["safety_kid"];
        var safetyCategory = data[0]["safety_category"];

        // Show the response data in a popup
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Login Related Safety Information"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        'assets/images/logo1.png', // Replace with an appropriate AnyDesk logo
                        height: 40,
                      ),
                      title: const Text("HPSCB"),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Safety Tips:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      safetyRemark,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 109, 156, 196)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        //Loader.hide();

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
