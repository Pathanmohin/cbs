// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/manage_beneficiary.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/model.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Deletepayee extends StatefulWidget {
  final List<Pending> Pendingg;

  const Deletepayee({super.key, required this.Pendingg});

  @override
  State<Deletepayee> createState() => _BeneficiaryListPageState();
}

class _BeneficiaryListPageState extends State<Deletepayee> {
  final List<Map<String, String>> payeeList = [
    {
      'payeeName': 'John Doe',
      'accNo': '1234567890',
      'status': 'Active',
    },
    {
      'payeeName': 'Jane Smith',
      'accNo': '0987654321',
      'status': 'Pending',
    },
    // Add more payees as needed
  ];
  String KID = "";
  String OTPVALUE = "";
  String Message = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Manage()));
        // Return false to prevent default back button behavior
        return false;
      },
      child: Builder(builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.1)),
          child: Scaffold(
            backgroundColor: const Color(0xFFFAF9F9),
            appBar: AppBar(
              backgroundColor: const Color(0xFF0057C2),
              title: const Text(
                'Beneficiary List',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Manage()));
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()));

                    //   context.go("/dashboard");
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
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: widget.Pendingg.length,
                itemBuilder: (context, index) {
                  final payee = widget.Pendingg[index];
                  return Card(
                    color: Colors.white,
                    // Set the background color of the Card here
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Beneficiary Name: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(
                                payee.nickName,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Account Number: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(
                                payee.accNo,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(
                                "Confirmed",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                String payeeName = payee.nickName;
                                String payeeN = payee.accNo;
                                KID = payee.kid;

                                await GetOTP();

                                showDialog(
                                    barrierDismissible: false,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    context: context,
                                    builder: (context) {
                                      return Builder(builder: (context) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              textScaler:
                                                  const TextScaler.linear(1.1)),
                                          child: AlertDialog(
                                            backgroundColor:
                                                AppColors.onPrimary,
                                            title: const Text('Enter OTP'),
                                            content: TextField(
                                              onChanged: (value) {
                                                OTPVALUE = value.toString();
                                              },
                                              // maxLengthEnforcement: MaxLengthEnforcement(6).,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    6)
                                              ],
                                              decoration: const InputDecoration(
                                                  hintText: 'Enter OTP'),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    String otp =
                                                        OTPVALUE.toString();

                                                    if (otp.length < 6) {
                                                      DialogboxAlert(
                                                          "Please Enter 6 digit OTP",
                                                          "Alert");
                                                      return;
                                                    }

                                                    _checkLatency(otp);

                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ))
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              },
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              child: const Text('Delete Beneficiary'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> GetOTP() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    // String apiUrl = "/rest/AccountService/sendOTP";

    String apiUrl = ApiConfig.sendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String jsonString = jsonEncode({
      "userID": userid,
      "beneficiaryAccNo": KID,
      "purpose": "Manage Payee",
      "sessionID": sessionId,
      "mobileNo": mobileNo,
    });
    //String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    String d = "data=$encrypted";

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
          } else {
            Loader.hide();
            Message = dataaa["Message"].toString();
            await Dialgbox(Message);
          }
        } else {
          Loader.hide();

          Message = "Server is not responding..!";
          await Dialgbox(Message);
        }
      } else {
        Loader.hide();
        await showDialog(
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
                    "Server Failed....!",
                    style: TextStyle(fontSize: 18),
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
    } catch (e) {
      Loader.hide();
      await showDialog(
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
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
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
  }

  Dialgbox(String MESSAGE) async {
    await showDialog(
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

  Future<void> FinalProceed(String MPIn) async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    //String apiUrl = "rest/AccountService/otpVerify";

    String apiUrl = ApiConfig.removePayee;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');

    String jsonString = jsonEncode({
      "beneficiaryAccNo": KID,
      "userID": userid,
      "sessionID": sessionId,
      "otp": MPIn,
      "mobileNo": mobileNo,
    });
    //String jsonString = jsonEncode(userInput.toJson());

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "tokenNo": tokenNo,
      "userID": userid,
    };

    // Convert data to JSON

    String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

    String d = "data=$encrypted";

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
        Loader.hide();
        var data = jsonDecode(response.body);

        if (data["Result"] == "Success") {
          var a = data["Data"];
          String decryptedResult = AESencryption.decryptString(a, ibUsrKid);
          var dataaa = jsonDecode(decryptedResult);

          if (dataaa["result"] == "success") {
            Message = "Payee Deleted Successfully..!";

            await Dialgbox(Message);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));

//context.go('/dashboard');
          } else {
            Message = dataaa["Error"];
            await Dialgbox(Message);
          }
        } else {
          Message = data["Message"];
          Dialgbox(Message);
        }
      } else {
        Loader.hide();
        await showDialog(
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
                    "Server Failed....!",
                    style: TextStyle(fontSize: 18),
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
    } catch (e) {
      Loader.hide();
      await showDialog(
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
                  "Unable to Connect to the Server",
                  style: TextStyle(fontSize: 18),
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
  }

  DialogboxAlert(String message, String Alert) async {
    await showDialog(
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

  Future<void> _checkLatency(String otp) async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    final stopwatch = Stopwatch()..start();

    try {
      var response = await http.get(Uri.parse('https://www.google.com/'));

      if (kDebugMode) {
        print(response.statusCode);
      }

      stopwatch.stop();
      if (response.statusCode == 200) {
        if (stopwatch.elapsedMilliseconds > 5000) {
          Loader.hide();
          await QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              headerBackgroundColor: Colors.yellow,
              title: 'Oops...',
              text:
                  "There’s a minor network issue at the moment. Click 'Yes' to keep your connection active, but be aware it might be risky. Select 'No' to log off securely.",
              confirmBtnText: 'Yes',
              cancelBtnText: 'No',
              onConfirmBtnTap: () {
                Navigator.pop(context);

                FinalProceed(otp);
              },
              onCancelBtnTap: () {
                Navigator.pop(context);
              },
              showCancelBtn: true,
              confirmBtnColor: Colors.green,
              barrierDismissible: false);
        } else {
          FinalProceed(otp);
        }
      } else {
        FinalProceed(otp);
      }
    } catch (e) {
      FinalProceed(otp);
    }
  }
}
