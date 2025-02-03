// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/presentation/view/dashboard/payments/manage_beneficiary/manage_beneficiary.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/alertbox.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddPayee extends StatefulWidget {
  const AddPayee({super.key});

  @override
  State<AddPayee> createState() => _AddPayeeState();
}

class _AddPayeeState extends State<AddPayee> {
  TextEditingController bname = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController accNumber = TextEditingController();
  TextEditingController accNumberCon = TextEditingController();
  TextEditingController setLimit = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankName = TextEditingController();

  String valueGet = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Loader.hide();

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Manage()));

            // context.pop(context);

            return false;
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "Add Beneficiary",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                backgroundColor: const Color(0xFF0057C2),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
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
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  //change your color here
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
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
                        child: SizedBox(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 10.0),
                                  child: Text(
                                    "Beneficiary Name",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextField(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      controller: bname,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Beneficiary Name',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 10.0),
                                  child: Text(
                                    "Nick Name",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextField(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      controller: nickName,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Nick Name',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 10.0),
                                  child: Text(
                                    "Account Number",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextField(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      controller: accNumber,
                                      obscureText: true,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Account Number',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 10.0),
                                  child: Text(
                                    "Confirm A/C Number",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextField(
                                      controller: accNumberCon,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Confirm A/C Number',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 10.0),
                                  child: Text(
                                    "Set Limit",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextField(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      controller: setLimit,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        hintText: 'Set Limit',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 10.0),
                                  child: Text(
                                    "IFSC Code",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 75,
                                    child: TextField(
                                      controller: ifscCode,
                                      //inputFormatters: <TextInputFormatter>[
                                      //   FilteringTextInputFormatter.allow(
                                      //       RegExp(r'[A-Z0-9]'))
                                      // ],
                                      textCapitalization:
                                          TextCapitalization.characters,

                                      // onTapOutside: (value) async{
                                      //   valueGet = ifscCode.text;

                                      //        if (ifscCode.text.length == 11) {
                                      //           await checkIFSC(ifscCode.text);
                                      //               }
                                      // },

                                      onChanged: (val) async {
                                        bankName.text = "";
                                      },

                                      onEditingComplete: () async {
                                        valueGet = ifscCode.text;

                                        bool val =
                                            await Utils.netWorkCheck(context);

                                        if (val == false) {
                                          return;
                                        }

                                        if (ifscCode.text.length == 11) {
                                          checkIFSC(ifscCode.text);
                                        }
                                      },

                                      onTapOutside: (val) {
                                        if (ifscCode.text == "") {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                title: "Alert",
                                                description:
                                                    "Please Enter IFSC Code",
                                              );
                                            },
                                          );

                                          return;
                                        } else if (ifscCode.text.length < 11) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                title: "Alert",
                                                description:
                                                    "Please Enter Valid IFSC Code",
                                              );
                                            },
                                          );
                                          return;
                                        }

                                        if (ifscCode.text.length == 11) {
                                          valueGet = ifscCode.text;

                                          checkIFSC(ifscCode.text);
                                        }
                                      },

                                      // onEditingComplete: () async{
                                      //    valueGet = ifscCode.text;

                                      //        if (ifscCode.text.length == 11) {
                                      //            await checkIFSC(ifscCode.text);
                                      //               }
                                      //    //_checkIFSCCode(ifscCode.text);
                                      // },

                                      // onSubmitted: (value) async{
                                      //   valueGet = ifscCode.text;

                                      //        if (ifscCode.text.length == 11) {
                                      //            await checkIFSC(ifscCode.text);
                                      //     }
                                      // },

                                      // onChanged: (value) => {

                                      //     valueGet = value,

                                      //   _checkIFSCCode(valueGet)

                                      // },

                                      maxLength: 11,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      decoration: const InputDecoration(
                                        hintText: 'Enter IFSC Code',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Bank Name",
                                    style: TextStyle(
                                        color: Color(0xFF0057C2),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextField(
                                      controller: bankName,
                                      enabled: false,
                                      onTap: () {
                                        if (ifscCode.text == "") {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                title: "Alert",
                                                description:
                                                    "Please Enter IFSC Code",
                                              );
                                            },
                                          );

                                          return;
                                        } else if (ifscCode.text.length < 11) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                title: "Alert",
                                                description:
                                                    "Please Enter Valid IFSC Code",
                                              );
                                            },
                                          );
                                          return;
                                        }
                                        checkIFSC(ifscCode.text);
                                        // Your onTap functionality here
                                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> IMPSOTP()));
                                      },
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      decoration: const InputDecoration(
                                        hintText: 'Bank Name',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // Your onTap functionality here

                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> IMPSOTP()));

                                    await _checkLatency();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 10.0),
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
                                              "PROCEED",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Image.asset(
                                                "assets/images/next.png"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ))),
              )),
        ),
      );
    });
  }

  // ADD Details of payee ..............................................................

// ignore: non_constant_identifier_names
  Future<void> AddDetails() async {
    if (ifscCode.text.length < 11 && ifscCode.text.length > 1) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Valid IFSC Code",
          );
        },
      );

      return;
    }

    if (bname.text.trim() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Beneficiary Name",
          );
        },
      );

      return;
    } else if (nickName.text.trim() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Nick Name",
          );
        },
      );

      return;
    } else if (accNumber.text.trim() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Account Number",
          );
        },
      );

      return;
    } else if (accNumberCon.text.trim() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Confirm Account No.",
          );
        },
      );

      return;
    } else if (accNumberCon.text.trim() != accNumber.text.trim()) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Account Number Mismatched",
          );
        },
      );

      return;
    } else if (setLimit.text.trim() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter Limit",
          );
        },
      );

      return;
    } else if (ifscCode.text.trim() == "") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Enter IFSC Code Number",
          );
        },
      );

      return;
    } else if (bankName.text.trim() == "")

    /// for ifsc code
    {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Please Verfy IFSC Code OR Bank Name",
          );
        },
      );

      return;
    }

    // String md5Hash = Crypt().generateMd5(accNumber.text);

    try {
      //  String ip = ServerDetails().getIPaddress();
      // String port = ServerDetails().getPort();
      // String protocol = ServerDetails().getProtocol();
      //   String? deviceId = await PlatformDeviceId.getDeviceId;

// Password Ency.
      // String md5Hash = Crypt().generateMd5("Bank@123");

      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "rest/AccountService/fundTransferAddPayee";

      String apiUrl = ApiConfig.fundTransferAddPayee;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
      String mobileNo = context.read<SessionProvider>().get('mobileNo');

      //String accountNo = context.read<SessionProvider>().get('accountNo');
      String sessionId = context.read<SessionProvider>().get('sessionId');

      String jsonString = jsonEncode({
        "nickName": nickName.text.trim(),
        "userID": userid,
        "payeeName": bname.text,
        "payeeAcc": accNumber.text,
        "payeeType": "O",
        "accountType": "S",
        "mobile": mobileNo.trim(),
        "ifscCode": ifscCode.text,
        "sessionID": sessionId,
        "mmid": "",
        "Limit": setLimit.text,
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
        // Make POST request
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

            String encrypted =
                AESencryption.decryptString(data["Data"], ibUsrKid);

            var res = jsonDecode(encrypted);

            if (res["authorise"].toString().toLowerCase() == "success") {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: "Request Successfully Processed",
                  );
                },
              );

              Navigator.pop(context);
            } else if (res["authorise"].toString().toLowerCase() == "all") {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: "Account is allready marked as payee",
                  );
                },
              );
            } else {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: "Alert",
                    description: "Server failed..!!",
                  );
                },
              );
            }

            //var res = jsonDecode(encrypted);
          } else {
            Loader.hide();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertBox(
                  title: "Alert",
                  description: "${data["Message"]}",
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
                description: "Unable To connect Server",
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
              description: "Unable To connect Server",
            );
          },
        );

        return;
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertBox(
            title: "Alert",
            description: "Unable To connect Server",
          );
        },
      );

      return;
    }
  }

  Future<void> checkIFSC(String data) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      // API endpoint URL

      // String apiUrl = "rest/AccountService/fetchIfscDetails/"+data;

      String apiUrl = '${ApiConfig.fetchIfscDetails}/$data';

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      // String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
      // String mobileNo = context.read<SessionProvider>().get('mobileNo');

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      // final parameters = <String, dynamic>{
      //   "data": "",
      // };

      try {
        var response = await http.get(
          Uri.parse(apiUrl),
          headers: headers,
        );

        if (response.statusCode == 200) {
          // ignore: unnecessary_null_comparison
          if (response.body != null || response.body != "") {
            var res = jsonDecode(response.body);

            if (res["status"].toString().toLowerCase() == "success") {
              Loader.hide();
              setState(() {
                bankName.text = res["bank name"].toString();
              });
              //bankName.text = res["bank name"].toString();
            } else {
              Loader.hide();

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertBox(
                      title: "Alert", description: "${res["error"]}");
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
                  description: "Server is not responding..!",
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
              description: "Unable to Connect to the Server",
            );
          },
        );

        return;
      }
    } catch (e) {
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

  Future<void> _checkLatency() async {
    final stopwatch = Stopwatch()..start();

    try {
      var response = await http.get(Uri.parse('https://www.google.com/'));

      if (kDebugMode) {
        print(response.statusCode);
      }

      stopwatch.stop();
      if (response.statusCode == 200) {
        if (stopwatch.elapsedMilliseconds > 5000) {
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

                AddDetails();
              },
              onCancelBtnTap: () {
                Navigator.pop(context);
              },
              showCancelBtn: true,
              confirmBtnColor: Colors.green,
              barrierDismissible: false);
        } else {
          AddDetails();
        }
      } else {
        AddDetails();
      }
    } catch (e) {
      AddDetails();
    }
  }
}
