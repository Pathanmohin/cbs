// ignore_for_file: non_constant_identifier_names, prefer_final_fields, deprecated_member_use, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/security/generatempin/Generatempin.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/presentation/widgets/maskingcode.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerfication extends StatefulWidget {
  const OTPVerfication({super.key});

  @override
  State<OTPVerfication> createState() => _OTPVerPAGE();
}

void datafounf() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  MPIN = prefs.getString("MPIN") ?? '';
}

String MPIN = "";
String Mobile = "";
String Message = "";

class _OTPVerPAGE extends State<OTPVerfication> {
  @override
  void initState() {
    super.initState();
    datafounf();
    // updateNumberInWords();
  }

  final otp = TextEditingController();
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
    String mobileNo = context.read<SessionProvider>().get('mobileNo');

    MaskedPhone maskedPhone = MaskedPhone("+", mobileNo);

    return WillPopScope(
      onWillPop: () async {
        // Show a dialog or perform any other action before navigating

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MpinGenerate()));

        //  context.pop(context);

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
                'OTP Verification',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MpinGenerate()),
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

                    // context.go("/dashboard");
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
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        'OTP Has been Sent on Register Mobile No.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        "Enter OTP (Sent to ${maskedPhone.countryCode + maskedPhone.phoneNo})",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
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
                          controller: otp,
                          length: 6,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20, top: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            //GetOTP();
                            bool val = await Utils.netWorkCheck(context);

                            if (val == false) {
                              return;
                            }

                            otp.text = "";

                            ResendOTP(context);
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
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
                            onPressed: () {
                              String PIN = otp.text;

                              if (otp.text.length < 4) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.onPrimary,
                                      title: const Text('Alert'),
                                      content: const Text(
                                          'Please Enter 6 digit OTP'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                GenerateMPIN();
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Verify OTP",
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

  void DialogboxAlert(String message, String Alert) {
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
      barrierDismissible: false,
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

  Future<void> GenerateMPIN() async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    String apiUrl = ApiConfig.genMPIN;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    // String branchCode = context.read<SessionProvider>().get('branchCode');
    // String customerId = context.read<SessionProvider>().get('customerId');
    String accountNo = context.read<SessionProvider>().get('accountNo');

    String jsonString = jsonEncode({
      "userid": userid,
      "beneficiaryAccNo": accountNo,
      "otp": otp.text,
      "MPIN":Crypt().generateMd5(MPIN), 
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

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        var data = response.body;
        var dataa = AESencryption.decryptString(
          data,
          ibUsrKid,
        );
        var dataaa = jsonDecode(dataa);

        if (dataaa["Result"] == "Success") {
          Loader.hide();
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
                      'Success',
                      style: TextStyle(fontSize: 18),
                    ),
                    content: Text(
                      dataaa["message"],
                      style: const TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));

                          // context.go("/dashboard");
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
          String message = dataaa["message"];
          Message = message;
          Dialgbox(Message);
          return;
        }
      } else {
        Loader.hide();
        Message = "Server is not responding....";
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

  Future<void> ResendOTP(BuildContext context) async {
    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    String apiUrl = ApiConfig.genPinSendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    // String branchCode = context.read<SessionProvider>().get('branchCode');
    // String customerId = context.read<SessionProvider>().get('customerId');
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
            Message = "Otp has been Successfully Send";
            Dialgbox(Message);
            return;
          } else {
            Message = dataaa["Message"].toString();
            Dialgbox(Message);
            return;
          }
        } else {
          Loader.hide();

          Message = "Server is not responding..!";
          Dialgbox(Message);
          return;
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
