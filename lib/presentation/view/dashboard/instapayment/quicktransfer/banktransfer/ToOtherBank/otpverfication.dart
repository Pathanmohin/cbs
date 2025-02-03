// ignore_for_file: non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/confirmdeatilstoother.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/selftransfer/selfaccountshow.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerfication extends StatefulWidget {
  const OtpVerfication({super.key});

  @override
  State<OtpVerfication> createState() => _OTPVerPAGE();
}

void datafounf() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  accno = prefs.getString("accno") ?? '';
  beneficiaryAccNo = prefs.getString("beneficiaryAccNo") ?? '';
  transferAmt = prefs.getString("transferAmt") ?? '';
  Remarks = prefs.getString("Remarks") ?? '';
  beneMobile = prefs.getString("beneMobile") ?? '';
  IFSCcode = prefs.getString("IFSCcode") ?? '';
  beneficiaryname = prefs.getString("beneficiaryname") ?? '';
}

String accno = "";
String beneficiaryAccNo = "";
String transferAmt = "";
String Remarks = "";
String IFSCcode = "";
String beneficiaryname = "";
String beneMobile = "";
String Message = "";
String Alert = "";
String MobilNumberFirst = "";
// ignore: unused_element
String? _otpCode;

class _OTPVerPAGE extends State<OtpVerfication> with CodeAutoFill {
  @override
  void initState() {
    super.initState();

    String mobileNo = context.read<SessionProvider>().get('mobileNo');

    MobilNumberFirst = mobileNo;
    datafounf();
    listenForCode();
    // updateNumberInWords();
  }

  @override
  void codeUpdated() {
    setState(() {
      pinController.text = code!; // Autofill the OTP in the pinController
    });
  }

  @override
  void dispose() {
    cancel(); // Stop listening for OTP when screen is disposed
    super.dispose();
  }

  final pinController = TextEditingController();
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
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFF0057C2),
            title: const Text(
              'OTP Verification',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfirmDeatilsToOther()),
                );

                //  context.pop(context);
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

                  //  context.go('/dashboard');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Image.asset(
                    CustomImages.home,
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
                      "Enter OTP $MobilNumberFirst",
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
                        // codeLength: 6, // Adjust this according to your OTP length
                        // onCodeChanged: (code) {
                        //   setState(() {
                        //     _otpCode = code;
                        //   });
                        // },
                        // onCodeSubmitted: (code) {
                        //   // Perform OTP verification
                        // },
                        defaultPinTheme: defaultTheme,
                        focusedPinTheme: focusedTheme,
                        submittedPinTheme: focusedTheme,
                        obscureText: _isPinObscured,
                        controller: pinController,
                        length: 6,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await GetOTP();
                          pinController.clear();
                        },
                        child: const Text(
                          "Resend OTP",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0057C2)),
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
                            bool val = await Utils.netWorkCheck(context);

                            if (val == false) {
                              return;
                            }
                            // ignore: unused_local_variable
                            String PIN = pinController.text;

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
                                            'Please Enter 6 digit OTP'),
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
                            } else {
                              FinalProceed(pinController.text);
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
    });
  }

  Future<void> FinalProceed(String MPIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // String ip = ServerDetails().getIPaddress();
    // String port = ServerDetails().getPort();
    // String protocol = ServerDetails().getProtocol();
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    // String apiUrl =
    //     "$protocol$ip$port/rest/AccountService/fundTransferwithinBank";

    String apiUrl = ApiConfig.fundTransferOtherBank;

    String date = "&quot;2017-04-06 11:53:46&quot";
    List<String> time = date.split(' ')[1].split(':');
    String scDate = date;

    scDate = scDate.substring(5, 7) +
        "/" +
        scDate.substring(8, 10) +
        "/" +
        scDate.substring(0, 4);

    scDate += " " + time[0] + "" + time[1] + "" + time[2];

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    String sessionId = context.read<SessionProvider>().get('sessionId');
    String customerId = context.read<SessionProvider>().get('customerId');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');

    String cusName = context.read<SessionProvider>().get('cusName');

    String jsonString = jsonEncode({
      "beneficiaryAccNo": beneficiaryAccNo,
      "accNo": accno,
      "userID": userid,
      "purpose": "Fund Transfer",
      "mobile": mobileNo,
      "sessionID": sessionId,
      "OTP": MPIn,
      "transferAmt": transferAmt,
      "mode": "P2A",
      "trnType": "O",
      "periodicity": "-1",
      "Remark": Remarks,
      "custID": customerId,
      "ftrnwith": "",
      "remiMobile": mobileNo,
      "beneMobile": beneMobile,
      "custName": cusName,
      "IFSCcode": IFSCcode,
      "CallFor": "I",
      'latitude': prefs.getString('latitude'),
      'longitude': prefs.getString('longitude'),
      'address': prefs.getString('address')
    });
    //String jsonString = jsonEncode(userInput.toJson());

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
        Loader.hide();
        var data = jsonDecode(response.body);

        if (data["Result"] == "Success") {
          var a = data["Data"];
          String decryptedResult = AESencryption.decryptString(a, ibUsrKid);
          var dataaa = jsonDecode(decryptedResult);

          if (dataaa["result"] == "success") {
            String res = dataaa["transactionID"].toString();

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: const TextScaler.linear(1.1)),
                    child: AlertDialog(
                      backgroundColor: AppColors.onPrimary,
                      title: const Text(
                        "Congratulations!!!!!!!!",
                        style: TextStyle(fontSize: 16),
                      ),
                      content: Text(
                        "Transaction Successfully Processed with ID:-$res",
                        style: const TextStyle(fontSize: 16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // ignore: unused_local_variable
                            String ReferenceID =
                                dataaa["transactionID"].toString();
                            String MODETYPE = "Quick Transfer";

                            ShowSelfData.RefId =
                                dataaa["transactionID"].toString();
                            ShowSelfData.Mode = MODETYPE;
                            ShowSelfData.ToAccount = beneficiaryAccNo;
                            ShowSelfData.Amount = transferAmt;
                            ShowSelfData.FromAccount = accno;

                            var now = DateTime.now();

                            String DateToday =
                                "${now.day}-${now.month}-${now.year}";

                            ShowSelfData.Date = DateToday;

                            ShowSelfData.Remark = Remarks;

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelfAccountShow()));

// -------------------------------------------------------------------------------------------------
                            // context.push('/SelfAccountShow');
// --------------------------------------------------------------------------------------------------------
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

            //transationdialog(Message, Alert);
          } else if (dataaa["result"] == "failure" &&
              dataaa["transactionID"].toString() == "-1" &&
              dataaa["Error"] == "InSufficient Balance") {
            Message = "Transaction Failed,Error Message-" +
                dataaa["Error"].toString();
            Alert = "Alert!!!!!!!!";
            DialogboxAlert(Message, Alert);
            return;
          } else if (dataaa["result"] == "failure" &&
              dataaa["Error"] == "OTP Mismatch") {
            Message = "Transaction Failed,Error Message-" +
                dataaa["Error"].toString();
            Alert = "Alert!!!!!!!!";
            DialogboxAlert(Message, Alert);
            return;
          } else if (dataaa["result"] == "failure" &&
              dataaa["transactionID"].toString() == "-1") {
            Message = "Transaction Failed,Error Message-" +
                dataaa["Error"].toString();
            Alert = "Alert!!!!!!!!";
            DialogboxAlert(Message, Alert);
            return;
          }
        } else {
          Message = data["Message"];
          Dialgbox(Message);
          return;
        }
      } else {
        Loader.hide();
        showDialog(
          context: context,
          builder: (BuildContext context) {
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
          },
        );
        return;
      }
    } catch (e) {
      Loader.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
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
        },
      );
      return;
    }
  }

  void DialogboxAlert(String message, String Alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  void transationdialog(String message, String Alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  void Dialgbox(String MESSAGE) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  Future<void> GetOTP() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    String apiUrl = ApiConfig.sendOTP;

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');
    //String accountNo = context.read<SessionProvider>().get('accountNo');

    OtpAccount userInput = OtpAccount(
        beneficiaryAccNo: beneficiaryAccNo,
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
          Loader.hide();
          var a = data["Data"];

          // var dataa = AESencryption.decryptString(
          //   a,
          //   Constants.AESENCRYPTIONKEY,
          // );
          var dataa = AESencryption.decryptString(a, ibUsrKid);
          var dataaa = jsonDecode(dataa);
          // String rona = dataa.toString();

          if (dataaa["authorise"] == "success") {
            // EnterOTP.IsVisible = true;
            // OTPSENT.Focus();

            //   OnIntraProcessClicked(result);
            Message = "Otp has been Successfully Send";
            Dialgbox(Message);

            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => OTP()));
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
}
