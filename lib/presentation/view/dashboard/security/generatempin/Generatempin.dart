// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_final_fields, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/security/generatempin/OtpVerfication.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MpinGenerate extends StatefulWidget {
  const MpinGenerate({super.key});

  @override
  State<MpinGenerate> createState() => _mpingenerate();
}

String Message = "";
String Alert = "";

class _mpingenerate extends State<MpinGenerate> {
  final newmpin = TextEditingController();
  final confirmmpin = TextEditingController();
  bool _isPinObscured = false;

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
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog or perform any other action before navigating
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Dashboard()));

        // context.pop(context);

        return false; // Return false to prevent the default back button behavior
      },
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFF0057C2),
              title: Text(
                'Create Mpin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );

                  // context.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );

                    //  context.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image.asset(
                      "assets/images/dashlogo.png",
                      width: 24.sp,
                      height: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 20),
                    child: Text(
                      'Enter New Mpin',
                      style: TextStyle(
                        fontSize: 18,
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
                          controller: newmpin,
                          length: 4,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 20),
                    child: Text(
                      'Confirm New Mpin',
                      style: TextStyle(
                        fontSize: 18,
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
                          controller: confirmmpin,
                          length: 4,
                        ),
                      ),
                    ],
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
                              String ConfirmMpin = confirmmpin.text;
                              // ignore: unused_local_variable
                              String NewMpin = newmpin.text;

                              bool val = await Utils.netWorkCheck(context);

                              if (val == false) {
                                return;
                              }

                              if (newmpin.text.length < 4) {
                                Message = "Please Enter 4 digit MPIN";
                                Dialgbox(Message);
                                return;
                              } else if (ConfirmMpin.length < 4) {
                                Message = "Please Enter 4 digit MPIN";
                                Dialgbox(Message);
                                return;
                                //FinalProceed(newmpin.text);
                              } else if (confirmmpin.text.toString() !=
                                  newmpin.text.toString()) {
                                Message = "Mpin is Mis matched..!";
                                Dialgbox(Message);
                                return;
                              }
                              GetOTP();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "PROCEED",
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
      }),
    );
  }

  void DialogboxAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                message,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void Dialgbox(String MESSAGE) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text(
                'Alert',
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                MESSAGE,
                style: const TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Future<void> GetOTP() async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();

    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    String apiUrl = ApiConfig.genPinSendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    String accountNo = context.read<SessionProvider>().get('accountNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String jsonString = jsonEncode({
      "userID": userid,
      "beneficiaryAccNo": accountNo,
      "purpose": "Mpin Generate",
      "sessionID": sessionId,
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    final parameters = <String, dynamic>{
      "data": encrypted,
    };
    final prefs = await SharedPreferences.getInstance();
    String MPIN = newmpin.text;

    prefs.setString("MPIN", MPIN);

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data["Result"] == "Success") {
          Loader.hide();
          var a = data["Data"];

          var dataa = AESencryption.decryptString(a, ibUsrKid);
          var dataaa = jsonDecode(dataa);
          // String rona = dataa.toString();

          if (dataaa["authorise"] == "success") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Builder(builder: (context) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.1)),
                    child: AlertDialog(
                      backgroundColor: AppColors.onPrimary,
                      title: const Text(
                        'Alert',
                        style: TextStyle(fontSize: 18),
                      ),
                      content: const Text(
                        "Otp has been Successfully Send",
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPVerfication()));

                            //    context.push('/OTPVerfication');
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
          } else {
            Loader.hide();
            Message = dataaa["Message"].toString();
            Dialgbox(Message);
          }
        } else {
          Loader.hide();

          Message = "Server is not responding..!";
          Dialgbox(Message);
        }
      } else {
        Loader.hide();
        Message = "Server Failed....!";
        Dialgbox(Message);
        return;
      }
    } catch (e) {
      Loader.hide();
      Message = "Unable to Connect to the Server";
      Dialgbox(Message);
      return;
    }
  }
}
