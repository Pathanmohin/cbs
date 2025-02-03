// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hpscb/data/models/loginmodel.dart';
import 'package:hpscb/data/models/withinbankquick.dart';
import 'package:hpscb/data/services/api_config.dart';
import 'package:hpscb/data/services/crypt.dart';
import 'package:hpscb/domain/entities/dashboardsave.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/IMPS/imps.dart';
import 'package:hpscb/presentation/view/dashboard/payments/tootherbank/NEFT&RTGS_Transfer/neft&rtgs.dart';
import 'package:hpscb/presentation/view/home/dashboard.dart';
import 'package:hpscb/presentation/viewmodel/session_provider.dart';
import 'package:hpscb/utility/theme/colors.dart';
import 'package:hpscb/utility/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ToOtherBankIMPS extends StatefulWidget {
  const ToOtherBankIMPS({super.key});

  @override
  State<StatefulWidget> createState() => _ToOtherBank();
}

class _ToOtherBank extends State<ToOtherBankIMPS> {
  @override
  void initState() {
    super.initState();
    saftyTipssss();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final screenWidth = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );

            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "To Other Bank",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: const Color(0xFF0057C2),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Container(
                        width: size.width,
                        height: 200,
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/bnktxn.png",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: screenWidth * 0.70,
                                    color: const Color(0xFF0057C2),
                                    child: const Center(
                                        child: Text(
                                      "OTHER BANK",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20.0),
                              child: Center(
                                  child: SizedBox(
                                width: 350,
                                height: 2,
                                child: Center(
                                    child: Container(
                                  color: Colors.black26,
                                )),
                              )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }
                                  SaveGlobalTitleIMNFRT.title = "IMPS Transfer";

                                  await ForIMPSAddBeny();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/impss.png",
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Text(
                                      "IMPS USING IFSC",
                                      style: TextStyle(
                                          color: Color(0xFF0057C2),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () async {
                                  bool val = await Utils.netWorkCheck(context);

                                  if (val == false) {
                                    return;
                                  }
                                  await ForNEFTAddBeny(context);

                                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomPicker()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/know.png",
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    const Text("NEFT AND RTGS",
                                        style: TextStyle(
                                            color: Color(0xFF0057C2),
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // API Code

  Future<void> ForIMPSAddBeny() async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/fetchPayeeIMPS";

      String apiUrl = ApiConfig.fetchPayeeIMPS;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
      String sessionId = context.read<SessionProvider>().get('sessionId');

      String jsonString = jsonEncode({
        "sessionID": sessionId,
        "userID": userid,
      });

      // Convert data to JSON

      String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        body: parameters,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      try {
        // Check if request was successful
        if (response.statusCode == 200) {
          if (response.body != "") {
            var res = jsonDecode(response.body);

            if (res["Data"] != "" || res["Data"] != null) {
              if (res["Result"].toString().toLowerCase() == "success") {
                String dencrypted =
                    AESencryption.decryptString(res["Data"], ibUsrKid);

                if (dencrypted == "[]" || dencrypted == []) {
                  Loader.hide();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Builder(builder: (context) {
                        return MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(1.1)),
                          child: AlertDialog(
                            backgroundColor: AppColors.onPrimary,
                            title: const Text(
                              'Alert',
                              style: TextStyle(fontSize: 18),
                            ),
                            content: const Text(
                              "Please Add Beneficiary",
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

                  return;
                }

                List<dynamic> parsedJson = jsonDecode(dencrypted);

                List<Payee> payees =
                    parsedJson.map((json) => Payee.fromJson(json)).toList();

                var payee_imps_list = <Payee>[];

                for (int i = 0; i < payees.length; i++) {
                  Payee pay = new Payee();
                  pay.nickName = payees[i].nickName;
                  pay.mobileNo = payees[i].mobileNo;
                  pay.accNo = payees[i].accNo;
                  pay.ifsCode = payees[i].ifsCode;
                  pay.payeeType = payees[i].payeeType;
                  pay.payeeName = payees[i].payeeName;
                  pay.accType = payees[i].accType;
                  pay.kid = payees[i].kid;

                  payee_imps_list.add(pay);
                }

                BenAdd.BenAddList = payee_imps_list;

                Loader.hide();

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => IMPS()));
              } else {
                Loader.hide();
              await  showDialog(
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

                return;
              }
            } else {
              Loader.hide();
            await  showDialog(
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
                  });

              return;
            }
          } else {
            Loader.hide();
          await  showDialog(
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
                });

            return;
          }
        } else {
       await   showDialog(
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

          return;
        }

        //   return;
      } catch (e) {
      await  showDialog(
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

        return;
      }
    } catch (e) {
    await  showDialog(
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

      return;
    }
  }

  Future<void> ForNEFTAddBeny(BuildContext context) async {
    try {
      Loader.show(context,
          progressIndicator: const CircularProgressIndicator());

      //String apiUrl = "rest/AccountService/fetchPayeeIMPS";

      String apiUrl = ApiConfig.fetchPayeeIMPS;

      String userid = context.read<SessionProvider>().get('userid');
      String tokenNo = context.read<SessionProvider>().get('tokenNo');
      String ibUsrKid = context.read<SessionProvider>().get('ibUsrKid');
      String sessionId = context.read<SessionProvider>().get('sessionId');

      String jsonString = jsonEncode({
        "sessionID": sessionId,
        "userID": userid,
      });

      // Convert data to JSON

      String encrypted = AESencryption.encryptString(jsonString, ibUsrKid);

      final parameters = <String, dynamic>{
        "data": encrypted,
      };

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "tokenNo": tokenNo,
        "userID": userid,
      };

      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          body: parameters,
          headers: headers,
          encoding: Encoding.getByName('utf-8'),
        );

        // Check if request was successful
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);

          if (responseData["Result"] == "Success") {
            String encrypted =
                AESencryption.decryptString(responseData["Data"], ibUsrKid);

            if (encrypted == "[]" || encrypted == []) {
              Loader.hide();
            await  showDialog(
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
                          "Please Add Beneficiary",
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

              return;
            }

            List<dynamic> parsedJson = jsonDecode(encrypted);

            List<Payee> payees =
                parsedJson.map((json) => Payee.fromJson(json)).toList();

            var payee_imps_list = <Payee>[];

            for (int i = 0; i < payees.length; i++) {
              Payee pay = new Payee();
              pay.nickName = payees[i].nickName.toString();
              pay.mobileNo = payees[i].mobileNo.toString();
              pay.accNo = payees[i].accNo.toString();
              pay.ifsCode = payees[i].ifsCode.toString();
              pay.payeeType = payees[i].payeeType.toString();
              pay.payeeName = payees[i].payeeName.toString();
              pay.accType = payees[i].accType.toString();
              pay.kid = payees[i].kid.toString();

              payee_imps_list.add(pay);
            }

            BenAdd.BenAddList = payee_imps_list;

            Loader.hide();

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NEFTRTGS()));
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

            return;
          }
        } else {
          Loader.hide();
        await  showDialog(
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

          return;
        }
      } catch (error) {
        Loader.hide();

      await  showDialog(
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

        return;
      }
    } catch (e) {
    await  showDialog(
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

      return;
    }
  }

  // --------------------- Vikas Method

  Future<void> saftyTipssss() async {
    //Loader.show(context, progressIndicator: CircularProgressIndicator());

    // String apiUrl = "$protocol$ip$port/rest/AccountService/fetchSafetytips";

    String apiUrl = ApiConfig.fetchSafetytips;

    String jsonString = jsonEncode({
      "category": "Transaction",
    });

    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    final parameters = <String, dynamic>{
      "data": jsonString,
    };

    try {
      // Make POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonString,
        headers: headers,
        encoding: Encoding.getByName('utf-8'),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Access the first item in the list and its safety_remark field
        var data = jsonDecode(responseData["Data"].toString());

        // Access the first item in the list and its safety_remark field
        var safetyRemark = data[0]["safety_remark"];
        var safetyKid = data[0]["safety_kid"];
        var safetyCategory = data[0]["safety_category"];

        // Show the response data in a popup
      await  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.onPrimary,
              title: const Text("Safety Information"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        'assets/images/logo1.png', // Replace with an appropriate AnyDesk logo
                        height: 40,
                      ),
                      title: const Text("HPSCB"),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Transaction Related Safety Tips:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      safetyRemark,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 17, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        if (kDebugMode) {
          print('Failed to get response');
        }
      }
    } catch (error) {
      // Loader.hide();

      return;
    }
  }
}
