// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/toothermodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/IMPS/imps.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/IMPS/impsotp.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ImpsCheck extends StatefulWidget {
  const ImpsCheck({super.key});
  @override
  State<StatefulWidget> createState() => _ImpsCheckState();
}

class _ImpsCheckState extends State<ImpsCheck> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title:  Text(
                "Confirm Your Details",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    },
                    child: Image.asset(
                      "assets/images/dashlogo.png",
                      width: 24.sp,
                      height: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              iconTheme: const IconThemeData(
                color: Colors.white,
                //change your color here
              ),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
                          ),
                          Flexible(
                            child: Text(
                              ToIMPSModel.name,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "From A/C:",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
                          ),
                          Text(
                            "${ToIMPSModel.fromAC}",
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "To A/C:",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
                          ),
                          Text(
                            "${ToIMPSModel.toAcAccount}",
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Amount:",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF0057C2))),
                          Text(
                            "\u{20B9}${ToIMPSModel.amountValue}",
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF0057C2)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                          child: SizedBox(
                        width: size.width * 0.9,
                        height: 2,
                        child: Center(
                            child: Container(
                          color: Colors.black26,
                        )),
                      )),
                    ),
                    InkWell(
                      onTap: () async {
                        // Your onTap functionality here

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> IMPSOTP()));

                        await getOTP();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0, left: 10.0, right: 10.0, bottom: 10.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057C2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Add some spacing between the icon and the text
                                const Text(
                                  "CONTINUE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.asset("assets/images/next.png"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))),
      );
    });
  }

  Future<void> getOTP() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String apiUrl = "rest/AccountService/sendOTP";

    String apiUrl = ApiConfig.sendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    OtpAccount userInput = OtpAccount(
        beneficiaryAccNo: ToIMPSModel.toAcAccount,
        userID: userid,
        purpose: "Fund Transfer",
        mobile: mobileNo,
        sessionID: sessionId);

    String jsonString = jsonEncode(userInput.toJson());

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
          String decryptedResult =
              AESencryption.decryptString(data["Data"], ibUsrKid);

          var d = jsonDecode(decryptedResult);

          if (d["authorise"] == "success") {
            Loader.hide();

            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IMPSOTP()));
          } else {
            Loader.hide();

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Builder(builder: (context) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.1)),
                    child: AlertDialog(
                      title: const Text(
                        'Alert',
                        style: TextStyle(fontSize: 16),
                      ),
                      content: const Text(
                        "Please try again",
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
          }

          print("OTP data:" + decryptedResult);
        } else {
          Loader.hide();

          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "${data["Message"].ToString()}",
              );
            },
          );
          return;
        }
      } else {
        Loader.hide();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Builder(builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.1)),
                child: AlertDialog(
                  title: const Text(
                    'Alert',
                    style: TextStyle(fontSize: 16),
                  ),
                  content: const Text(
                    "Server Failed....!",
                    style: TextStyle(fontSize: 16),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      }
    } catch (e) {
      Loader.hide();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.1)),
              child: AlertDialog(
                title: const Text(
                  'Alert',
                  style: TextStyle(fontSize: 16),
                ),
                content: const Text(
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 16),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    }
  }
}
