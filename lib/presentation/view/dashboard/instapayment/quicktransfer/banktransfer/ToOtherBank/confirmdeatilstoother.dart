// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/dashboarddatamodel.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/otpverfication.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/ToOtherBank/toothertransfer.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/icon_image/custom_images.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfirmDeatilsToOther extends StatefulWidget {
  const ConfirmDeatilsToOther({super.key});

  @override
  State<StatefulWidget> createState() => _ConfirmDeatilsToOtherState();
}

class _ConfirmDeatilsToOtherState extends State<ConfirmDeatilsToOther> {
  // String transferAmt = '1234'; // example amount
  String numberInWords = '';
  String accno = "";
  String beneficiaryAccNo = "";
  String transferAmt = "";
  String Remarks = "";
  String IFSCcode = "";
  String beneficiaryname = "";
  String beneMobile = "";

  String Message = "";

  @override
  void initState() {
    super.initState();
    dataFound();
    // updateNumberInWords();
  }

  Future<void> dataFound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accno = prefs.getString("accno") ?? '';
      beneficiaryAccNo = prefs.getString("beneficiaryAccNo") ?? '';
      transferAmt = prefs.getString("transferAmt") ?? '';
      Remarks = prefs.getString("Remarks") ?? '';
      beneMobile = prefs.getString("beneMobile") ?? '';
      IFSCcode = prefs.getString("IFSCcode") ?? '';
      beneficiaryname = prefs.getString("beneficiaryname") ?? '';
    });
  }

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
            title: Text(
              'Confirm Your Details',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ToOtherBank()));

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

                  //  context.go('/dashboard');
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
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
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            beneficiaryname,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "From A/C:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            accno,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "To A/C:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            beneficiaryAccNo,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Amount:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            transferAmt,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF002E5B),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool val = await Utils.netWorkCheck(context);

                        if (val == false) {
                          return;
                        }
                        GetOTP();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Container(
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0057C2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "CONTINUE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> GetOTP() async {
    Loader.show(context, progressIndicator: const CircularProgressIndicator());

    String apiUrl = ApiConfig.sendOTP;
    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');

    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    // String customerId = context.read<SessionProvider>().get('customerId');
    String sessionId = context.read<SessionProvider>().get('sessionId');

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

            // Navigator.push(context, MaterialPageRoute(builder: (context) => OTP()));

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OtpVerfication()));

            //  context.push('/OtpVerfication');
// --------------------------------------------------------------------------------------------------------
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
}
