// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hpscb/presentation/view/applydashboard/currentaccount/CAAadhaarDetails/CAAadhaarDetails.dart';
import 'package:hpscb/presentation/view/applydashboard/savingaccount/saveverifydata.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:http/http.dart' as http;

class CAAadhaarOTP extends StatefulWidget {
  const CAAadhaarOTP({super.key});
  @override
  State<StatefulWidget> createState() => _CAAadhaarOTPState();
}

class _CAAadhaarOTPState extends State<CAAadhaarOTP> {
  final TextEditingController _otpController = TextEditingController();
  int _remainingTime = 58;
  bool _isResendEnabled = false;
  String? formattedNumber;

  @override
  void initState() {
    super.initState();
    formattedNumber = formatNumber(SaveVerifyData.aadharNumberVerify);
    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startCountdown();
      } else {
        setState(() {
          _isResendEnabled = true;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      _remainingTime = 158;
      _isResendEnabled = false;
    });
    _startCountdown();
    // Logic to resend the OTP code
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
            title:  Text(
              "Aadhaar Verify",
              style: TextStyle(color: Colors.white,fontSize: 16.sp),
            ),
            backgroundColor: const Color(0xFF0057C2),
            iconTheme: const IconThemeData(
              color: Colors.white,
              //change your color here
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's verify your aadhaar number",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      formattedNumber.toString(),
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(width: 8),
                    // Icon(Icons.edit, color: Colors.orange),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    hintText: "Enter the six-digit code",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const IdentityPage()));

                      getAadhaarRes();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0057C2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _remainingTime > 0
                          ? '$_remainingTime seconds'
                          : "Didn't receive a code?",
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (_isResendEnabled)
                      TextButton(
                        onPressed: _isResendEnabled ? _resendCode : null,
                        child: const Text('Send again'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  String formatNumber(String number) {
    if (number.length < 4) {
      return number;
    }
    String prefix = number.substring(0, 4); // Get the first 4 characters
    String masked = 'X' * (number.length - 4); // Mask the remaining characters
    return '$prefix$masked';
  }

  Future<void> getAadhaarDetails() async {
    try {
     
      // String? deviceId = await PlatformDeviceId.getDeviceId;

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl = "rest/AccountService/aadharotpsend";

      String jsonString = jsonEncode({
        "aadhaarnumber": SaveVerifyData.aadharNumberVerify,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);

          if (data["statusCode"] == "200") {
            if (data["aadhaar_validation"] != "") {
              Map<String, dynamic> getData = data["aadhaar_validation"];

              if (getData["statusCode"] == 200) {
                var getRes = getData["data"];

                if (getRes != null || getRes != "") {
                  String requestId = getRes["requestId"].toString();
                  // String status = getRes["status"].toString();

                  String msg = getData["message"].toString();

                  Loader.hide();
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertBox(
                        title: "Success",
                        description: msg,
                      );
                    },
                  );

                  //   SaveVerifyData.aadharNumberVerify = aadhaarController.text;
                  SaveVerifyData.reqIDGen = requestId;
                  
                } else {
                  Loader.hide();
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertBox(
                        title: "Alert",
                        description: getData["message"].toString(),
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
                      description: getData["message"].toString(),
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
                    description: "Server failed..!",
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
                  description: "Server failed..!",
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
                description: "Server failed..!",
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
              description: "Unable to Connect to the Server",
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
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }

  Future<void> getAadhaarRes() async {
    if (_otpController.text.length < 6) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: 'Please Enter Correct OTP',
          );
        },
      );

      return;
    }

    try {
 
      // String? deviceId = await PlatformDeviceId.getDeviceId;

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      String apiUrl = "rest/AccountService/aadharotpverify";

      String jsonString = jsonEncode({
        "clientid": SaveVerifyData.reqIDGen,
        "otp": _otpController.text,
      });

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        if (response.statusCode == 200 ||
            response.statusCode.toString() == "200") {
          if (response.body.isNotEmpty) {
            var data = jsonDecode(response.body);
            var getDataList = data[0];

            if (getDataList["statusCode"].toString() == "200") {
              Loader.hide();

              var dataGet = getDataList["aadhaar_otp_submit"];

              if (dataGet["statusCode"] == "200" ||
                  dataGet["statusCode"] == 200) {
                var datafirst = dataGet["data"];

                AadhaarcardVerifyuser.client_id = datafirst["client_id"]
                    .toString(); //"aadhaar_v1_Tk33p2LmWQBKKLbZumVJ",
                AadhaarcardVerifyuser.full_name =
                    datafirst["full_name"].toString(); //"Mohit Sahu",
                AadhaarcardVerifyuser.aadhaar_number =
                    datafirst["aadhaar_number"].toString(); //"953527038357"
                AadhaarcardVerifyuser.dob =
                    datafirst["dob"].toString(); // "2000-05-12",

                if (datafirst["gender"] == "M") {
                  AadhaarcardVerifyuser.gender = "Male"; //"M",
                } else {
                  AadhaarcardVerifyuser.gender = "Female"; //"M",
                }

                //Address List
                var dataaddress = datafirst["address"];
                AadhaarcardVerifyuser.country =
                    dataaddress["country"].toString(); //"India",
                AadhaarcardVerifyuser.dist =
                    dataaddress["dist"].toString(); // "Jaipur",
                AadhaarcardVerifyuser.state =
                    dataaddress["state"].toString(); // "Rajasthan",
                AadhaarcardVerifyuser.po =
                    dataaddress["po"].toString(); // "Jaipur City",
                AadhaarcardVerifyuser.loc =
                    dataaddress["loc"].toString(); // "ghatgate",
                AadhaarcardVerifyuser.vtc =
                    dataaddress["vtc"].toString(); //"Jaipur",
                AadhaarcardVerifyuser.subdist =
                    dataaddress["subdist"].toString(); // "",
                AadhaarcardVerifyuser.street =
                    dataaddress["street"].toString(); // "",
                AadhaarcardVerifyuser.house =
                    dataaddress["house"].toString(); //  "",
                AadhaarcardVerifyuser.landmark = dataaddress["landmark"]
                    .toString(); // "4744/22,dadiya house purani kotwali ka rasta"

                AadhaarcardVerifyuser.face_status =
                    datafirst["face_status"]; //"face_status": false,
                AadhaarcardVerifyuser.face_score =
                    datafirst["face_score"]; // -1,
                AadhaarcardVerifyuser.zip =
                    datafirst["zip"].toString(); // "302003",
                AadhaarcardVerifyuser.profile_image =
                    datafirst["profile_image"]; //image

                AadhaarcardVerifyuser.has_image =
                    datafirst["has_image"]; //"has_image": true,

                AadhaarcardVerifyuser.email_hash =
                    datafirst["email_hash"].toString();
                AadhaarcardVerifyuser.mobile_hash = datafirst["mobile_hash"]
                    .toString(); //"mobile_hash": "8760da2f333ef13cee1e1d03002d66ecd1e805bb2cde8763779d2ca75629c01a",
                AadhaarcardVerifyuser.zip_data = datafirst["zip_data"]
                    .toString(); //"zip_data": "https://persist.signzy.tech/api/files/963781670/download/f1e4e9aa65554368a2b1faa3a34ca71a53acf71588704e9cb34d75bad370efe1.zip",
                AadhaarcardVerifyuser.raw_xml = datafirst["raw_xml"]
                    .toString(); //"raw_xml": "https://persist.signzy.tech/api/files/963781669/download/502475a6518f4e6596aa93fd1066cb7401d638e2737a4e60804be7c639f6d27c.xml",

                AadhaarcardVerifyuser.care_of = datafirst["care_of"]
                    .toString(); //"care_of": "S/O Surendra Kumar",
                AadhaarcardVerifyuser.share_code =
                    datafirst["share_code"].toString(); // "share_code": "1234",
                AadhaarcardVerifyuser.mobile_verified =
                    datafirst["mobile_verified"]; //"mobile_verified": false,
                AadhaarcardVerifyuser.reference_id = datafirst["reference_id"]
                    .toString(); // "reference_id": "835720240806135000272",
                //   String aadhaar_pdf = datafirst["aadhaar_pdf"]; // "aadhaar_pdf": null,
                AadhaarcardVerifyuser.status = datafirst["status"]
                    .toString(); // "status": "success_aadhaar",
                AadhaarcardVerifyuser.uniqueness_id = datafirst["uniqueness_id"]
                    .toString(); // "uniqueness_id": ""

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CAAadhaarCard()));
              } else {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertBox(
                      title: "Alert",
                      description: dataGet["message"].toString(),
                    );
                  },
                );

                return;
              }
            }

            if (kDebugMode) {
              print(data);
            }
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "Server failed..!",
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
                description: "Server failed..!",
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
              description: "Unable to Connect to the Server",
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
            description: "Unable to Connect to the Server",
          );
        },
      );

      return;
    }
  }
}
