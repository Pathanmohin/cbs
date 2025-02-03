// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/config/constants.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/viewmodel/mpinauth_viewmodel.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mpin extends StatefulWidget {
  const Mpin({super.key});

  @override
  State<Mpin> createState() => _MpinState();
}

class _MpinState extends State<Mpin> {
  final pinController = TextEditingController();
  bool _isPinObscured = true;
  String dropdownValue = "";

  PinTheme defaultTheme = PinTheme(
    height: 45,
    width: 45,
    textStyle: const TextStyle(
      fontSize: 20,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: const Color(0xFF0057C2),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  PinTheme focusedTheme = PinTheme(
    height: 45,
    width: 45,
    textStyle: const TextStyle(
      fontSize: 20,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo1.png',
                    width: 170,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      'Welcome To HPSCB',
                      style: TextStyle(fontSize: 25, color: Color(0xFF0057C2)),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      "Please Enter 4-Digit Pin",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Pinput(
                          defaultPinTheme: defaultTheme,
                          focusedPinTheme: focusedTheme,
                          submittedPinTheme: focusedTheme,
                          obscureText: _isPinObscured,
                          controller: pinController,
                          onChanged: (pin) async {
                            if (pin.length == 4) {
                              bool val = await Utils.netWorkCheck(context);

                              if (val == false) {
                                return;
                              }
// Api call -------------------------------------------------------------------------------------
                              postData(context, pinController.text);
                              pinController.clear();
                            }
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.sp, top: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_isPinObscured == false) {
                            setState(() {
                              _isPinObscured = true; // Toggle the boolean value
                            });
                          } else {
                            setState(() {
                              _isPinObscured =
                                  false; // Toggle the boolean value
                            });
                          }
                        },
                        child: Text(
                          "View Mpin",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: const Color(0xFF0057C2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () async {
                            // ignore: unused_local_variable
                            String PIN = pinController.text;

                            bool val = await Utils.netWorkCheck(context);

                            if (val == false) {
                              return;
                            }

                            if (pinController.text.length < 4) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Builder(builder: (context) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          textScaler:
                                              const TextScaler.linear(1.1)),
                                      child: AlertDialog(
                                        backgroundColor: AppColors.onPrimary,
                                        title: const Text('Alert'),
                                        content: const Text(
                                            'Please Enter 4 digit MPin'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );

                              return;
                            } else {
                              postData(context, pinController.text);
// Api cal ------------------------------------------------------------------------------------------------------
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> postData(BuildContext context, String userID) async {
    final mpinviewModel =
        Provider.of<MpinauthViewmodel>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  String md5Hash = Crypt().generateMd5(userID);

    Map<String, dynamic> data = {
      'MPIN': md5Hash,
      'Type': "WITHMPIN",
      'SIMNO': androidInfo.id.toString(),
      'MobVer': '26',
      'latitude': prefs.getString('latitude'),
      'longitude': prefs.getString('longitude'),
      'address': prefs.getString('address')
    };

    String jsonString = jsonEncode(data);

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    // Convert data to JSON

    String encrypted =
        AESencryption.encryptString(jsonString, Constants.AESENCRYPTIONKEY);

    final parameters = <String, dynamic>{
      "data": encrypted,
    };

    mpinviewModel.mpinLogin(parameters, headers, context);
  }
}
