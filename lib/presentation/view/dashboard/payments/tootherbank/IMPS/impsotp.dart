import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:hpscb/data/models/toothermodel.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/instapayment/quicktransfer/banktransfer/selftransfer/selfaccountshow.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/IMPS/impscheck.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/presentation/widgets/maskingcode.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IMPSOTP extends StatefulWidget {
  const IMPSOTP({super.key});

  @override
  State<StatefulWidget> createState() => _IMPSOTPState();
}

class _IMPSOTPState extends State<IMPSOTP> {
  String otpKey = "";

  @override
  Widget build(BuildContext context) {
    
    String mob = context.read<SessionProvider>().get('mobileNo');

    MaskedPhone maskedPhone = MaskedPhone("+", mob);

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              "OTP Verification",
              style: TextStyle(color: Colors.white),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "OTP has been Sent on Registered Mobile",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
                const Center(
                    child: Text(
                  "No.",
                  style: TextStyle(fontSize: 20),
                )),
                Center(
                    child: Text(
                  "Enter OTP (Sent to ${maskedPhone.countryCode + maskedPhone.phoneNo})",
                  style: TextStyle(fontSize: 16),
                )),
                const SizedBox(
                  height: 10,
                ),
                VerificationCodeField(
                  length: 6,
                  onFilled: (value) => setState(() {
                    otpKey = value;
                  }),
                  size: Size(30, 60),
                  spaceBetween: 16,
                  matchingPattern: RegExp(r'^\d+$'),
                ),
                InkWell(
                  onTap: () async {
                    await finalResponse();

                    // Your onTap functionality here
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> IMPSOTP()));
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
                        // Add some spacing between the icon and the text
                        child: Text(
                          "VERIFY OTP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  bool getValid(String value) {
    String valueCheck = value.toLowerCase();

    String d = "InSufficient Balance";

    if (valueCheck == d.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  bool isDigitsOnly(String str) {
    return str.split('').every((char) => int.tryParse(char) != null);
  }

  Future<void> finalResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String beneficiaryname = ToIMPSModel.name;

    if (otpKey.toString().length < 6) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter 6 Digit OTP",
          );
        },
      );

      return;
    } else if (!isDigitsOnly(otpKey)) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Numeric Number",
          );
        },
      );

      return;
    }

    if (SaveGlobalTitleIMNFRT.title == "IMPS Transfer") {
      SaveTitleConData.callfortype = "I";
      SaveTitleConData.beneficarynameimps = "0";
      SaveTitleConData.MODETYPE = "IMPS Transfer";
    }

    if (SaveGlobalTitleIMNFRT.title == "NEFT Transfer") {
      SaveTitleConData.callfortype = "N";
      SaveTitleConData.beneficarynameimps = beneficiaryname;
      SaveTitleConData.MODETYPE = "NEFT Transfer";
    }

    if (SaveGlobalTitleIMNFRT.title == "RTGS Transfer") {
      SaveTitleConData.callfortype = "R";
      SaveTitleConData.beneficarynameimps = beneficiaryname;
      SaveTitleConData.MODETYPE = "RTGS Transfer";
    }

    Loader.show(context, progressIndicator: CircularProgressIndicator());

    String userid = context.read<SessionProvider>().get('userid');
    String tokenNo = context.read<SessionProvider>().get('tokenNo');
    String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
    String mobileNo = context.read<SessionProvider>().get('mobileNo');
    String sessionId = context.read<SessionProvider>().get('sessionId');
    String customerId = context.read<SessionProvider>().get('customerId');
    String cusName = context.read<SessionProvider>().get('cusName');

    // String apiUrl = "$protocol$ip$port/rest/AccountService/fundTransferOtherBank";

    String apiUrl = ApiConfig.fundTransferOtherBank;

    String jsonString = jsonEncode({
      "beneficiaryAccNo": ToIMPSModel.toAcAccount,
      "accNo": ToIMPSModel.fromAC,
      "userID": userid,
// purpose = "Fund Transfer",
      "purpose": "IMPSBridge",
      "mobile": mobileNo,
      "sessionID": sessionId,
      "OTP": otpKey,
      "transferAmt": ToIMPSModel.amountValue,
      "mode": "P2A",
      "trnType": "O",
      "periodicity": "-1",
      "Remark": ToIMPSModel.remark,
      "custID": customerId,
      "ftrnwith": "",
      "remiMobile": mobileNo,
      "beneMobile": mobileNo,
      "custName": cusName,
      "IFSCcode": ToIMPSModel.ifsccode,
      "CallFor": SaveTitleConData.callfortype,
      "sBeneFicaryName": SaveTitleConData.beneficarynameimps,
      'latitude': prefs.getString('latitude').toString(),
      'longitude': prefs.getString('longitude').toString(),
      'address': prefs.getString('address').toString()
    });

    //  String jsonString = jsonEncode(userInput.toJson());

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
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      if (response.statusCode == 200) {
        if (response.body == "") {
          Loader.hide();
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertBox(
                title: "Alert",
                description: "Server is not responding..!",
              );
            },
          );

          return;
        } else {
          var resCheck = jsonDecode(response.body);

          if (resCheck["Result"] == "success") {
            var data = AESencryption.decryptString(resCheck["Data"], ibUsrKid);
            var res = jsonDecode(data);

            if (res["result"] == "success") {
              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: 'Congratulations!!!!!!!!',
                    description:
                        "Transaction Successfully Processed with ID:- ${res["transactionID"]}",
                  );
                },
              );

              ShowSelfData.RefId = res["transactionID"];
              ShowSelfData.Mode = SaveTitleConData.MODETYPE;
              ShowSelfData.ToAccount = ToIMPSModel.toAcAccount;
              ShowSelfData.Amount = ToIMPSModel.amountValue;
              ShowSelfData.FromAccount = ToIMPSModel.fromAC;

              var now = DateTime.now();

              String DateToday = "${now.day}-${now.month}-${now.year}";

              ShowSelfData.Date = DateToday;

              ShowSelfData.Remark = ToIMPSModel.remark;

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SelfAccountShow()));
            } else if (res["result"].toString().toLowerCase() == "failure" &&
                res["transactionID"] == "-1" &&
                getValid(res["Error"])) {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: 'Alert!!!!!!!!',
                    description:
                        "Transaction Failed,Error Message- ${res["Error"]}",
                  );
                },
              );

              return;
            } else if (res["result"].toString().toLowerCase() == "failure" &&
                res["Error"].toString().toLowerCase() ==
                    "OTP Mismatch".toLowerCase()) {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: 'Alert!!!!!!!!',
                    description:
                        "Transaction Failed,Error Message- ${res["Error"]}",
                  );
                },
              );

              return;
            } else if (res["result"].toString().toLowerCase() == "failure" &&
                res["transactionID"] == "-1") {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: 'Alert!!!!!!!!',
                    description:
                        "Transaction Failed,Error Message- ${res["Error"]}",
                  );
                },
              );

              return;
            } else {
              Loader.hide();
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: "Transaction Failed..!",
                  );
                },
              );

              return;
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "${resCheck["Message"]}",
                );
              },
            );

            return;
          }
        }
      } else {
        Loader.hide();
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertBox(
              title: "Alert",
              description: "Server is not responding..!",
            );
          },
        );

        return;
      }
    } catch (e) {
      Loader.hide();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "${e}",
          );
        },
      );

      return;
    }
  }
}
